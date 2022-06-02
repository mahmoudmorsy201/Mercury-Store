//
//  CartRow.swift
//  Mercury-Store
//
//  Created by mac hub on 01/06/2022.
//

import Foundation

struct CartRow {
    let uuid: UUID
    var products: [CartProduct]
}

extension CartRow {
    init(products: [CartProduct]) {
        self.uuid = UUID()
        self.products = products
    }
    
    var rowTotal: Int {
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
