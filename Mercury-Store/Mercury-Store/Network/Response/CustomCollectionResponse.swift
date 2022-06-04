//
//  CustomCollectionResponse.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 31/05/2022.
//

import Foundation

// MARK: - Welcome
struct MainCstegories: Codable {
    let customCollections: [CustomCollection]

    enum CodingKeys: String, CodingKey {
        case customCollections = "custom_collections"
    }
}

// MARK: - CustomCollection
struct CustomCollection: Codable {
    let id: Int
    let handle, title: String
    let updatedAt: Date
    let bodyHTML: String?
    let publishedAt: Date
    let sortOrder: String
    let templateSuffix: String?
    let publishedScope, adminGraphqlAPIID: String
    let image: Image?

    enum CodingKeys: String, CodingKey {
        case id, handle, title
        case updatedAt = "updated_at"
        case bodyHTML = "body_html"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case templateSuffix = "template_suffix"
        case publishedScope = "published_scope"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case image
    }
}
