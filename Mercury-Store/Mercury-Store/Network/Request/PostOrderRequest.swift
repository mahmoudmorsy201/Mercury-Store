//
//  PostOrderRequest.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 11/06/2022.
//

import Foundation
/*
 {
   "order": {
     "line_items": [
       {
         "variant_id": 447654529,
         "quantity": 1
       }
     ],
     "customer": {
       "id": 207119551
     },
     "financial_status": "pending"
   }
 }
 */
struct OrderRequest:Encodable{
    let order: OrderRequestItem
}
// MARK: - Order
struct OrderRequestItem: Codable {
    let lineItems: [LineItemOrder]
    let customer: CustomerOrderRequst
    enum CodingKeys: String, CodingKey {
        case lineItems = "line_items"
        case customer
    }
}

// MARK: - Customer
struct CustomerOrderRequst: Codable {
    let id: Int
}

// MARK: - LineItem
struct LineItemOrder: Codable {
    let variantID, quantity: Int
    enum CodingKeys: String, CodingKey {
        case variantID = "variant_id"
        case quantity
    }
}
