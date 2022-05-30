//
//  ShoppingCartModels.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation

struct ShoppingCartItem {
    let id = UUID()
    let imageName: String
    let productName: String
    var productPrice: Int
    var quantity: Int = 1
}

extension ShoppingCartItem: Equatable {}
