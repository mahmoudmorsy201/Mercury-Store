//
//  PricesRoleReponse.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 11/06/2022.
//

import Foundation

struct PricesRoleResponse: Codable {
    let priceRules: [PriceRule]

    enum CodingKeys: String, CodingKey {
        case priceRules = "price_rules"
    }
}

// MARK: - PriceRule
struct PriceRule: Codable {
    let id: Int
    let valueType, value, customerSelection, targetType: String
    let targetSelection, allocationMethod: String
    let allocationLimit: JSONNull?
    let oncePerCustomer: Bool
    let usageLimit: JSONNull?
    let startsAt: Date
    let endsAt: JSONNull?
    let createdAt, updatedAt: Date
    let entitledProductIDS, entitledVariantIDS, entitledCollectionIDS, entitledCountryIDS: [JSONAny]
    let prerequisiteProductIDS, prerequisiteVariantIDS, prerequisiteCollectionIDS, customerSegmentPrerequisiteIDS: [JSONAny]
    let prerequisiteCustomerIDS: [JSONAny]
    let prerequisiteSubtotalRange, prerequisiteQuantityRange, prerequisiteShippingPriceRange: JSONNull?
    let prerequisiteToEntitlementQuantityRatio: PrerequisiteToEntitlementQuantityRatio
    let prerequisiteToEntitlementPurchase: PrerequisiteToEntitlementPurchase
    let title, adminGraphqlAPIID: String

    enum CodingKeys: String, CodingKey {
        case id
        case valueType = "value_type"
        case value
        case customerSelection = "customer_selection"
        case targetType = "target_type"
        case targetSelection = "target_selection"
        case allocationMethod = "allocation_method"
        case allocationLimit = "allocation_limit"
        case oncePerCustomer = "once_per_customer"
        case usageLimit = "usage_limit"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case entitledProductIDS = "entitled_product_ids"
        case entitledVariantIDS = "entitled_variant_ids"
        case entitledCollectionIDS = "entitled_collection_ids"
        case entitledCountryIDS = "entitled_country_ids"
        case prerequisiteProductIDS = "prerequisite_product_ids"
        case prerequisiteVariantIDS = "prerequisite_variant_ids"
        case prerequisiteCollectionIDS = "prerequisite_collection_ids"
        case customerSegmentPrerequisiteIDS = "customer_segment_prerequisite_ids"
        case prerequisiteCustomerIDS = "prerequisite_customer_ids"
        case prerequisiteSubtotalRange = "prerequisite_subtotal_range"
        case prerequisiteQuantityRange = "prerequisite_quantity_range"
        case prerequisiteShippingPriceRange = "prerequisite_shipping_price_range"
        case prerequisiteToEntitlementQuantityRatio = "prerequisite_to_entitlement_quantity_ratio"
        case prerequisiteToEntitlementPurchase = "prerequisite_to_entitlement_purchase"
        case title
        case adminGraphqlAPIID = "admin_graphql_api_id"
    }
}

// MARK: - PrerequisiteToEntitlementPurchase
struct PrerequisiteToEntitlementPurchase: Codable {
    let prerequisiteAmount: JSONNull?

    enum CodingKeys: String, CodingKey {
        case prerequisiteAmount = "prerequisite_amount"
    }
}

// MARK: - PrerequisiteToEntitlementQuantityRatio
struct PrerequisiteToEntitlementQuantityRatio: Codable {
    let prerequisiteQuantity, entitledQuantity: JSONNull?

    enum CodingKeys: String, CodingKey {
        case prerequisiteQuantity = "prerequisite_quantity"
        case entitledQuantity = "entitled_quantity"
    }
}

