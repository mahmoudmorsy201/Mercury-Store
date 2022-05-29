//
//  ShoppingCartRepository.swift
//  Mercury-Store
//
//  Created by mac hub on 29/05/2022.
//
import RxCocoa
import RxSwift
import Foundation

class ShoppingCartRepository {
    let scheduler = SerialDispatchQueueScheduler(qos: .background)
    func refreshValues() -> Observable<[ShoppingCartItem]> {
        let scheduler = self.scheduler
        return Observable.deferred {
            let models = self.all
            return .just(models, scheduler: scheduler).debug()
        }
    }
    let all: [ShoppingCartItem] = [
        ShoppingCartItem(imageName: "wishlist", productName: "Adidas1", productPrice: 13),
        ShoppingCartItem(imageName: "wishlist", productName: "Adidas2", productPrice: 13),
        ShoppingCartItem(imageName: "wishlist", productName: "Adidas3", productPrice: 13),
        ShoppingCartItem(imageName: "wishlist", productName: "Adidas4", productPrice: 13),
        ShoppingCartItem(imageName: "wishlist", productName: "Adidas5", productPrice: 13),
        ShoppingCartItem(imageName: "wishlist", productName: "Adidas6", productPrice: 13),
    ]
}
