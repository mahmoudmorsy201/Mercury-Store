//
//  PostOrderRequest.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 11/06/2022.
//

import Foundation

struct DraftOrdersRequest: Codable {
    let draftOrder: DraftOrderItem

    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}
struct PostOrderRequest: Codable {
    let order: DraftOrderItem
}
// MARK: - DraftOrder
struct DraftOrderItem: Codable {
    let lineItems: [LineItemDraft]
    let customer: CustomerId
    let useCustomerDefaultAddress: Bool

    enum CodingKeys: String, CodingKey {
        case lineItems = "line_items"
        case customer
        case useCustomerDefaultAddress = "use_customer_default_address"
    }
}

// MARK: - Customer
struct CustomerId: Codable {
    let id: Int
}

// MARK: - LineItem
struct LineItemDraft: Codable {
    let quantity, variantID: Int

    enum CodingKeys: String, CodingKey {
        case quantity
        case variantID = "variant_id"
    }
}

struct PutOrderRequest: Codable {
    let draftOrder: ModifyDraftOrderRequest

    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}

struct ModifyDraftOrderRequest: Codable {
    let dratOrderId: Int
    let lineItems: [LineItemDraft]
    
    enum CodingKeys: String, CodingKey {
        case lineItems = "line_items"
        case dratOrderId = "id"
    }
}
