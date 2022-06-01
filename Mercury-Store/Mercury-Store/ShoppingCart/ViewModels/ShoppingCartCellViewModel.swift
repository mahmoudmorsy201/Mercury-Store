//
//  ShoppingCartCellViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 30/05/2022.
//

import Foundation

struct CartCellViewModel {
    let row: CartRow
    var product: CartProduct! { row.products.first }
    var image: String? { product?.productImage }
    var name: String? { product?.productName }
    var price: String? { "EGP \(row.rowTotal)" }
    var count: String { "\(row.products.count)" }
}

