//
//  ProfileModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}



// MARK: - Customer
struct Customer: Codable {
    let customer: CustomerClass
}

struct AllCustomers:Codable {
    let customers: [CustomerResponse]
}

// MARK: - CustomerClass
struct CustomerClass: Codable {
    let firstName, lastName, email: String
    let password : String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case password = "tags"
    }
}

// MARK: - RegisterResponse
struct RegisterResponse: Codable {
    let customer: CustomerResponse
}

struct CustomerResponse: Codable {
    let id: Int
    let email: String
    let acceptsMarketing: Bool
    let createdAt, updatedAt: Date
    let firstName, lastName: String
    let ordersCount: Int
    let state, totalSpent: String
    let lastOrderID: Int?
    let note: String?
    let verifiedEmail: Bool
    let taxExempt: Bool
    let phone: String?
    let tags: String
    let currency: String
    let addresses: [Address]

    enum CodingKeys: String, CodingKey {
        case id, email
        case acceptsMarketing = "accepts_marketing"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case ordersCount = "orders_count"
        case state
        case totalSpent = "total_spent"
        case lastOrderID = "last_order_id"
        case note
        case verifiedEmail = "verified_email"
        case taxExempt = "tax_exempt"
        case phone, tags
        case currency, addresses
    }
}

// MARK: - Address
struct Address: Codable {
    let id, customerID: Int
    let firstName, lastName: String
    let address1: String
    let address2: String?
    let city, province, country, zip: String
    let phone, name, provinceCode, countryCode: String
    let countryName: String
    let addressDefault: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case address1, address2, city, province, country, zip, phone, name
        case provinceCode = "province_code"
        case countryCode = "country_code"
        case countryName = "country_name"
        case addressDefault = "default"
    }
}
