//
//  ShoppingCartViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//
import Foundation
import RxSwift
import RxCocoa

protocol ShoppingCartNavigationFlow: AnyObject {
    func goToAddAddressScreen()
    func goToPaymentScreen()
}
enum CartAction {
    case increment(SavedProductItem)
    case decrement(SavedProductItem)
    case deleteItem(SavedProductItem)
    case viewIsLoaded
    case proceedToCheckout
}

struct CartInput {
    let viewLoaded: Observable<Void>
}

struct CartOutput {
    let cart: Observable<[CartSection]>
    let cartTotal: Observable<String?>
    let cartEmpty: Observable<Bool>
    let cartBadge: Observable<String?>
    let checkoutVisible: Observable<(visible: Bool, animated: Bool)>
}


final class CartViewModel {
    private weak var shoppingCartNavigationFlow: ShoppingCartNavigationFlow!
    private let incrementProductSubject = PublishSubject<SavedProductItem>()
    private let decrementProductSubject = PublishSubject<SavedProductItem>()
    private let deleteProductSubject = PublishSubject<SavedProductItem>()
    private let cartOrderSubject = PublishSubject<DraftOrderResponseTest>()
    var incrementProduct: AnyObserver<SavedProductItem> { incrementProductSubject.asObserver() }
    var decrementProduct: AnyObserver<SavedProductItem> { decrementProductSubject.asObserver() }
    var deleteProduct: AnyObserver<SavedProductItem> { deleteProductSubject.asObserver() }
    let ordersProvider: OrdersProvider
    let disposeBag = DisposeBag()
    init(shoppingCartNavigationFlow: ShoppingCartNavigationFlow,ordersProvider: OrdersProvider = OrdersClient()) {
        self.shoppingCartNavigationFlow = shoppingCartNavigationFlow
        self.ordersProvider = ordersProvider
    }
    
    func viewDidDisappear() {
        modifyOrderInCartApi()
    }
    
    private func modifyOrderInCartApi() {
        let user = getUserFromUserDefaults()
        if(user != nil) {
            if(user!.cartId != 0) {
                let savedItemsInCart = CartCoreDataManager.shared.getDataFromCoreData()
                let coreDataLineDraft = savedItemsInCart.map { LineItemDraft(quantity: $0.productQTY, variantID: $0.variantId)}
                
                self.ordersProvider.modifyExistingOrder(with: user!.cartId, and: PutOrderRequest(draftOrder: ModifyDraftOrderRequest(dratOrderId: user!.cartId, lineItems: coreDataLineDraft)))
                    .subscribe(onNext: {[weak self] result in
                        guard let `self` = self else {fatalError()}
                        self.cartOrderSubject.onNext(result)
                    }).disposed(by: disposeBag)
            }
        }
    }
    func checkUserExists() -> Bool{
        let user = getUserFromUserDefaults()
        if(user != nil) {
            return true
        }else {
            return false
        }
       
    }
    func goToAddAddressScreen() {
        shoppingCartNavigationFlow.goToAddAddressScreen()
    }
    private func getUserFromUserDefaults() -> User? {
        do {
            return try UserDefaults.standard.getObject(forKey: "user", castTo: User.self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func bind(_ input: CartInput) -> CartOutput {
         let cart = Observable
            .merge(
                input.viewLoaded.map{CartAction.viewIsLoaded},
                incrementProductSubject.map { CartAction.increment($0) },
                decrementProductSubject.map { CartAction.decrement($0) },
                deleteProductSubject.map { CartAction.deleteItem($0) }
            )
        
            .scan(CartState.empty()) { (state, action) in
                state.execute(action)
            }
            .map { $0.sections }
            .share()
        return CartOutput(
            cart: cart,
            cartTotal: cart.map(cartTotal()),
            cartEmpty: cart.map(cartEmpty()),
            cartBadge: cart.map(cartTotalCount()),
            checkoutVisible: cart.map(checkoutVisible())
                .startWith((visible: false, animated: false)))
    }
        
    func cartTotal() -> (_ cart: [CartSection]) -> String? {
        {  "EGP \($0[safe: 0]?.sectionTotal ?? 0)" }
    }
    
    func cartTotalCount() -> (_ cart: [CartSection]) -> String? {
        { "\($0[safe: 0]?.totalCount ?? 0)" }
    }
    
    func cartEmpty() -> (_ cart: [CartSection]) throws -> Bool {
        { $0[safe: 0]?.rows.count == 0 }
    }
    
    func checkoutVisible() -> (_ cart: [CartSection]) throws -> (visible: Bool, animated: Bool) {
        { $0[safe: 0]?.rows.count == 0 ? (visible: false, animated: true) : (visible: true, animated: true) }
    }
}
