//
//  CartRow.swift
//  Mercury-Store
//
//  Created by mac hub on 01/06/2022.
//

import Foundation

struct CartRow {
    let uuid: UUID
    var products: [SavedProductItem]
}

extension CartRow {
    init(products: [SavedProductItem]) {
        self.uuid = UUID()
        self.products = products
    }
    
    var rowTotal: Double {
        products.reduce(0) { result, product in
            result + product.productPrice
            
        }
    }
}

extension CartRow : Equatable {
    var identity: UUID {
        return uuid
    }
}

func ==(lhs: CartRow, rhs: CartRow) -> Bool {
    return lhs.uuid == rhs.uuid
}
