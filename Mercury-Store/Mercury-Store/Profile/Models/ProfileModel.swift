//
//  ProfileModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation

struct Customers {
    let customers: [Customer]
}

// MARK: - Customer
struct Customer  {
    let id: Int
    let email: String
    let createdAt, updatedAt: Date
    let firstName, lastName , tags: String
    let ordersCount: Int
    let totalSpent: String
    let lastOrderID: Int?
    let verifiedEmail: Bool
    let phone: String
    let lastOrderName: String?
    let addresses: [Address]
    let defaultAddress: Address
}
struct Address  {
    let id, customerID: Int
    let firstName, lastName: String
    let company: NSNull
    let address1: String
    let city, province, country, zip: String
    let phone, name: String
    let countryCode, countryName: String
    let addressDefault: Bool
}
