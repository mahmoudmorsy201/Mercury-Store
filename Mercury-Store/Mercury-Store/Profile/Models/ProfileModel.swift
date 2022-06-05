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

struct Customers :Codable{
    let customers: [Customer]
}

// MARK: - Customer
struct Customer :Codable {
    let id: Int?
    let email: String?
    let createdAt, updatedAt: Date?
    let firstName, lastName , tags: String?
    let ordersCount: Int?
    let totalSpent: String?
    let lastOrderID: Int?
    let verifiedEmail: Bool?
    let phone: String?
    let lastOrderName: String?
    let addresses: [Address]?
    let defaultAddress: Address?
}

struct Address :Codable {
    let id, customerID: Int?
    let firstName, lastName: String?
    let address1: String?
    let city, province, country, zip: String?
    let phone, name: String?
    let countryCode, countryName: String?
    let addressDefault: Bool?
}
