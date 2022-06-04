//
//  BrandsCollectionResponse.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//


import Foundation

// MARK: - SmartCollection
struct SmartCollection: Codable {
    let smartCollections: [SmartCollectionElement]

    enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
    }
}


// MARK: - SmartCollectionElement
struct SmartCollectionElement: Codable {
    let id: Int
    let handle, title: String
    let updatedAt: Date
    let bodyHTML: String
    let publishedAt: Date
    let sortOrder: SortOrder
    let templateSuffix: String?
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

// MARK: - Image
struct Image: Codable {
    let createdAt: Date
    let alt: String?
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
