//
//  CartCoreDataManager.swift
//  Mercury-Store
//
//  Created by mac hub on 01/06/2022.
//

import Foundation

class CartCoreDataManager {
    static let shared = CartCoreDataManager()
    let all = [
        CartProduct(productImage: "wishlist", productName: "Adidas1", productPrice: 13),
        CartProduct(productImage: "wishlist", productName: "Adidas2", productPrice: 13),
        CartProduct(productImage: "wishlist", productName: "Adidas3", productPrice: 13),
        CartProduct(productImage: "wishlist", productName: "Adidas4", productPrice: 13),
        CartProduct(productImage: "wishlist", productName: "Adidas5", productPrice: 13),
        CartProduct(productImage: "wishlist", productName: "Adidas6", productPrice: 13),
        CartProduct(productImage: "wishlist", productName: "Adidas7", productPrice: 13)
    ]
    private init() {
        
    }
    
    func getDataFromCoreData() -> [CartProduct] {
        return all
    }
}
