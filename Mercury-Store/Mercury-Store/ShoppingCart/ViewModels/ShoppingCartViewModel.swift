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
    
}
enum CartAction {
    case increment(CartProduct)
    case decrement(CartProduct)
    case deleteItem(CartProduct)
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
    let checkoutVisible: Observable<(visible: Bool, animated: Bool)>
}


final class CartViewModel {
    private weak var shoppingCartNavigationFlow: ShoppingCartNavigationFlow!
    private let incrementProductSubject = PublishSubject<CartProduct>()
    private let decrementProductSubject = PublishSubject<CartProduct>()
    private let deleteProductSubject = PublishSubject<CartProduct>()
    var incrementProduct: AnyObserver<CartProduct> { incrementProductSubject.asObserver() }
    var decrementProduct: AnyObserver<CartProduct> { decrementProductSubject.asObserver() }
    var deleteProduct: AnyObserver<CartProduct> { deleteProductSubject.asObserver() }
    
    
    init(shoppingCartNavigationFlow: ShoppingCartNavigationFlow) {
        self.shoppingCartNavigationFlow = shoppingCartNavigationFlow
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
            checkoutVisible: cart.map(checkoutVisible())
                .startWith((visible: false, animated: false)))
    }
        
    func cartTotal() -> (_ cart: [CartSection]) -> String? {
        {  "EGP \($0[safe: 0]?.sectionTotal ?? 0)" }
    }
    
    func cartEmpty() -> (_ cart: [CartSection]) throws -> Bool {
        { $0[safe: 0]?.rows.count == 0 }
    }
    
    func checkoutVisible() -> (_ cart: [CartSection]) throws -> (visible: Bool, animated: Bool) {
        { $0[safe: 0]?.rows.count == 0 ? (visible: false, animated: true) : (visible: true, animated: true) }
    }
}

extension CartViewModel: ShoppingCartNavigationFlow {
    
}


