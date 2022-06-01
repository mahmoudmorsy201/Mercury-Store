//
//  ShoppingCartModels.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation
import RxDataSources

struct CartProduct {
    let productImage: String
    let productName: String
    var productPrice: Int
}

extension CartProduct: Equatable { }


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

extension CartRow : IdentifiableType,Equatable {
    var identity: UUID {
        return uuid
    }
}

func ==(lhs: CartRow, rhs: CartRow) -> Bool {
    return lhs.uuid == rhs.uuid
}


struct CartSection {
    let uuid: UUID
    var rows: [CartRow]
}

extension CartSection {
    init(_ rows: [CartRow]) {
        self.uuid = UUID()
        self.rows = rows
    }
    
    var sectionTotal: Int {
        rows.reduce(0) { result, row in
            result + row.rowTotal
        }
    }
}

extension CartSection: AnimatableSectionModelType {
    var identity: UUID { uuid }
    var items: [CartRow] { rows }
    
    init(original: CartSection, items: [CartRow]) {
        self = original
        self.rows = items
    }
}

