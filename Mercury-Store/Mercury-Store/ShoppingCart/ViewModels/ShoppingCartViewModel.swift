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
    case viewIsLoaded
    case checkout
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


struct CartViewModel {
    private let incrementProductSubject = PublishSubject<CartProduct>()
    private let decrementProductSubject = PublishSubject<CartProduct>()
    var incrementProduct: AnyObserver<CartProduct> { incrementProductSubject.asObserver() }
    var decrementProduct: AnyObserver<CartProduct> { decrementProductSubject.asObserver() }
    
    
    func bind(_ input: CartInput) -> CartOutput {
         let cart = Observable
            .merge(
                input.viewLoaded.map{CartAction.viewIsLoaded},
                incrementProductSubject.map { CartAction.increment($0) },
                decrementProductSubject.map { CartAction.decrement($0) })
        
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
        {  String($0[safe: 0]?.sectionTotal ?? 0) }
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
