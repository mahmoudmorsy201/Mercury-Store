//
//  OrderPostResponse.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 11/06/2022.
//

import Foundation


// MARK: - DraftOrderResponse
struct DraftOrderResponse: Codable {
    let draftOrder: DraftOrder

    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}


// MARK: - DraftOrder
struct DraftOrder: Codable {
    let id: Int
    let email: String
    let name, status: String
    let lineItems: [LineItemRespons]
    let customer: CustomerOrderResponse

    enum CodingKeys: String, CodingKey {
        case id, email
        case name, status
        case lineItems = "line_items"
        case customer
    }
}

struct CustomerOrderResponse: Codable {
    let id: Int
    let email: String
    let cartId: String
    let password: String
    let favouriteId: String
    let defaultAddress: Address
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case cartId = "note"
        case password = "tags"
        case favouriteId = "multipass_identifier"
        case defaultAddress = "default_address"
    }
}


// MARK: - DefaultAddress
struct DefaultAddress: Codable {
    let id, customerID: Int
    let firstName, lastName, company, address1: String
    let address2, city, province, country: String
    let zip, phone, name, provinceCode: String
    let countryCode, countryName: String
    let defaultAddressDefault: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case company, address1, address2, city, province, country, zip, phone, name
        case provinceCode = "province_code"
        case countryCode = "country_code"
        case countryName = "country_name"
        case defaultAddressDefault = "default"
    }
}

// MARK: - LineItem
struct LineItemRespons: Codable {
    let id, variantID, productID: Int
    let title, variantTitle, sku, vendor: String
    let quantity: Int
    let requiresShipping, taxable, giftCard: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case variantID = "variant_id"
        case productID = "product_id"
        case title
        case variantTitle = "variant_title"
        case sku, vendor, quantity
        case requiresShipping = "requires_shipping"
        case taxable
        case giftCard = "gift_card"
    }
}
