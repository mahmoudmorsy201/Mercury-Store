//
//  ShoppingCartCellViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 30/05/2022.
//

import Foundation

struct ShoppingCartCellViewModel {
    let imageName: String
    let productName: String
    var productPrice: Int
    var quantity: Int = 1
    
    init(usingModel model: ShoppingCartItem) {
        self.imageName = model.imageName
        self.productName = model.productName
        self.productPrice = model.productPrice
        self.quantity = model.quantity
    }
}
