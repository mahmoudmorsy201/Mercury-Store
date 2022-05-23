//
//  BrandsCollectionResponse.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let smartCollection = try? newJSONDecoder().decode(SmartCollection.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSmartCollection { response in
//     if let smartCollection = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - SmartCollection
struct SmartCollection: Codable {
    let smartCollections: [SmartCollectionElement]

    enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSmartCollectionElement { response in
//     if let smartCollectionElement = response.result.value {
//       ...
//     }
//   }

// MARK: - SmartCollectionElement
struct SmartCollectionElement: Codable {
    let id: Int
    let handle, title: String
    let updatedAt: Date
    let bodyHTML: String
    let publishedAt: Date
    let sortOrder: SortOrder
    let templateSuffix: JSONNull?
    let disjunctive: Bool
    let rules: [Rule]
    let publishedScope: PublishedScope
    let adminGraphqlAPIID: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id, handle, title
        case updatedAt = "updated_at"
        case bodyHTML = "body_html"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case templateSuffix = "template_suffix"
        case disjunctive, rules
        case publishedScope = "published_scope"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case image
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseImage { response in
//     if let image = response.result.value {
//       ...
//     }
//   }

// MARK: - Image
struct Image: Codable {
    let createdAt: Date
    let alt: JSONNull?
    let width, height: Int
    let src: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case alt, width, height, src
    }
}

enum PublishedScope: String, Codable {
    case web = "web"
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRule { response in
//     if let rule = response.result.value {
//       ...
//     }
//   }

// MARK: - Rule
struct Rule: Codable {
    let column: Column
    let relation: Relation
    let condition: String
}

enum Column: String, Codable {
    case title = "title"
}

enum Relation: String, Codable {
    case contains = "contains"
}

enum SortOrder: String, Codable {
    case bestSelling = "best-selling"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}




