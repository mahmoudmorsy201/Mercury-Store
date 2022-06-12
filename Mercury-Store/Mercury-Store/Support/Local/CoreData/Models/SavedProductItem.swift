//
//  SavedProductItem.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 03/06/2022.
//

import Foundation
struct SavedProductItem{
    var variantId: Int
    var productID:Decimal
    var productTitle:String
    var productImage:String
    var productPrice:Double
    var productQTY:Int
    var producrState:Int
}
extension SavedProductItem {
    init() {
        productTitle = ""
        productID = 0
        productImage = ""
        productPrice = 0
        productQTY = 0
        // 0 favourite -- 1 cart -- 2cart
        producrState = 0
        variantId = 0
    }
}

extension SavedProductItem: Equatable {}
