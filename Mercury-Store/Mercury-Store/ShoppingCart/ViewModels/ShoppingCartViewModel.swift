//
//  ShoppingCartViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//
import Foundation
import RxSwift
import RxCocoa

enum CartAction {
    case increment(CartProduct)
    case decrement(CartProduct)
    case checkout
}

struct CartOutput {
    let cart: Driver<[CartSection]>
    let cartTotal: Observable<String?>
    let cartEmpty: Observable<Bool>
    let checkoutVisible: Observable<(visible: Bool, animated: Bool)>
}


struct CartViewModel {
    private let incrementProductSubject = PublishSubject<CartProduct>()
    private let decrementProductSubject = PublishSubject<CartProduct>()
    var incrementProduct: AnyObserver<CartProduct> { incrementProductSubject.asObserver() }
    var decrementProduct: AnyObserver<CartProduct> { decrementProductSubject.asObserver() }
    private let subject = PublishSubject<[CartSection]>()
    func fetchDataFromCoreData() {
        let productsSections = CartCoreDataManager.shared.getDataFromCoreData().map{CartRow(products: [$0])}.map{CartSection([$0])}
        //cartProductsSubject.onNext(productsSections)
    }
    
    init() {
        
    }
    
    func bind() -> CartOutput {
         let cart = Observable
            .merge(
                incrementProductSubject.map { CartAction.increment($0) },
                decrementProductSubject.map { CartAction.decrement($0) })
            
            .scan(CartState.empty()) { (state, action) in
                state.execute(action)
            }
            .map { $0.sections }
            .debug("cart")
            .share()
        
        return CartOutput(
            cart: cart,
            cartTotal: cart.map(cartTotal()),
            cartEmpty: cart.map(cartEmpty()),
            checkoutVisible: cart.map(checkoutVisible())
                .startWith((visible: false, animated: false)))
    }
        
    func cartTotal() -> (_ cart: [CartSection]) -> String? {
        { String(describing: $0[safe: 0]?.sectionTotal) }
    }
    
    func cartEmpty() -> (_ cart: [CartSection]) throws -> Bool {
        { $0[safe: 0]?.rows.count == 0 }
    }
    
    func checkoutVisible() -> (_ cart: [CartSection]) throws -> (visible: Bool, animated: Bool) {
        { $0[safe: 0]?.rows.count == 0 ? (visible: false, animated: true) : (visible: true, animated: true) }
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

//extension Int {
//    var decimalCurrency: Double {
//        return Double(self) / 100.0
//    }
//
//    var decimalCurrencyString: String {
//        let locale = Locale.current
//        let numberFormatter = NumberFormatter()
//        numberFormatter.currencyCode = locale.currencyCode
//        numberFormatter.locale = locale
//        numberFormatter.minimumFractionDigits = 2
//        numberFormatter.maximumFractionDigits = 2
//        guard let value = numberFormatter.string(from: NSNumber(value: decimalCurrency)) else { fatalError("Could not format decimal currency: \( decimalCurrency)") }
//        guard let symbol = locale.currencySymbol else { fatalError("Could not find currency symbol for locale: \(locale)") }
//        return "\(symbol)\(value)"
//    }
//}
