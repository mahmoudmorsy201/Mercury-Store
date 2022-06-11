//
//  OrderPostResponse.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 11/06/2022.
//

import Foundation
struct OrderPostResponse: Codable {
    let order: OrderItemPostResponse
}

// MARK: - Order
struct OrderItemPostResponse: Codable {
    let id: Int
    let adminGraphqlAPIID: String
    let appID: Int
    let browserIP: JSONNull?
    let buyerAcceptsMarketing: Bool
    let cancelReason, cancelledAt, cartToken, checkoutID: JSONNull?
    let checkoutToken, clientDetails, closedAt: JSONNull?
    let confirmed: Bool
    let contactEmail: JSONNull?
    let createdAt: Date
    let currency: Currency
    let currentSubtotalPrice: String
    let currentSubtotalPriceSet: Set
    let currentTotalDiscounts: String
    let currentTotalDiscountsSet: Set
    let currentTotalDutiesSet: JSONNull?
    let currentTotalPrice: String
    let currentTotalPriceSet: Set
    let currentTotalTax: String
    let currentTotalTaxSet: Set
    let customerLocale, deviceID: JSONNull?
    let discountCodes: [JSONAny]
    let email: String
    let estimatedTaxes: Bool
    let financialStatus: String
    let fulfillmentStatus: JSONNull?
    let gateway: String
    let landingSite, landingSiteRef, locationID: JSONNull?
    let name: String
    let note: JSONNull?
    let noteAttributes: [JSONAny]
    let number, orderNumber: Int
    let orderStatusURL: String
    let originalTotalDutiesSet: JSONNull?
    let paymentGatewayNames: [JSONAny]
    let phone: JSONNull?
    let presentmentCurrency: Currency
    let processedAt: Date
    let processingMethod: String
    let reference, referringSite, sourceIdentifier: JSONNull?
    let sourceName: String
    let sourceURL: JSONNull?
    let subtotalPrice: String
    let subtotalPriceSet: Set
    let tags: String
    let taxLines: [JSONAny]
    let taxesIncluded, test: Bool
    let token, totalDiscounts: String
    let totalDiscountsSet: Set
    let totalLineItemsPrice: String
    let totalLineItemsPriceSet: Set
    let totalOutstanding, totalPrice: String
    let totalPriceSet: Set
    let totalPriceUsd: String
    let totalShippingPriceSet: Set
    let totalTax: String
    let totalTaxSet: Set
    let totalTipReceived: String
    let totalWeight: Int
    let updatedAt: Date
    let userID, billingAddress, customer: JSONNull?
    let discountApplications, fulfillments: [JSONAny]
    let lineItems: [LineItemResponse]
    let paymentDetails: JSONNull?
    let refunds: [JSONAny]
    let shippingAddress: JSONNull?
    let shippingLines: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case appID = "app_id"
        case browserIP = "browser_ip"
        case buyerAcceptsMarketing = "buyer_accepts_marketing"
        case cancelReason = "cancel_reason"
        case cancelledAt = "cancelled_at"
        case cartToken = "cart_token"
        case checkoutID = "checkout_id"
        case checkoutToken = "checkout_token"
        case clientDetails = "client_details"
        case closedAt = "closed_at"
        case confirmed
        case contactEmail = "contact_email"
        case createdAt = "created_at"
        case currency
        case currentSubtotalPrice = "current_subtotal_price"
        case currentSubtotalPriceSet = "current_subtotal_price_set"
        case currentTotalDiscounts = "current_total_discounts"
        case currentTotalDiscountsSet = "current_total_discounts_set"
        case currentTotalDutiesSet = "current_total_duties_set"
        case currentTotalPrice = "current_total_price"
        case currentTotalPriceSet = "current_total_price_set"
        case currentTotalTax = "current_total_tax"
        case currentTotalTaxSet = "current_total_tax_set"
        case customerLocale = "customer_locale"
        case deviceID = "device_id"
        case discountCodes = "discount_codes"
        case email
        case estimatedTaxes = "estimated_taxes"
        case financialStatus = "financial_status"
        case fulfillmentStatus = "fulfillment_status"
        case gateway
        case landingSite = "landing_site"
        case landingSiteRef = "landing_site_ref"
        case locationID = "location_id"
        case name, note
        case noteAttributes = "note_attributes"
        case number
        case orderNumber = "order_number"
        case orderStatusURL = "order_status_url"
        case originalTotalDutiesSet = "original_total_duties_set"
        case paymentGatewayNames = "payment_gateway_names"
        case phone
        case presentmentCurrency = "presentment_currency"
        case processedAt = "processed_at"
        case processingMethod = "processing_method"
        case reference
        case referringSite = "referring_site"
        case sourceIdentifier = "source_identifier"
        case sourceName = "source_name"
        case sourceURL = "source_url"
        case subtotalPrice = "subtotal_price"
        case subtotalPriceSet = "subtotal_price_set"
        case tags
        case taxLines = "tax_lines"
        case taxesIncluded = "taxes_included"
        case test, token
        case totalDiscounts = "total_discounts"
        case totalDiscountsSet = "total_discounts_set"
        case totalLineItemsPrice = "total_line_items_price"
        case totalLineItemsPriceSet = "total_line_items_price_set"
        case totalOutstanding = "total_outstanding"
        case totalPrice = "total_price"
        case totalPriceSet = "total_price_set"
        case totalPriceUsd = "total_price_usd"
        case totalShippingPriceSet = "total_shipping_price_set"
        case totalTax = "total_tax"
        case totalTaxSet = "total_tax_set"
        case totalTipReceived = "total_tip_received"
        case totalWeight = "total_weight"
        case updatedAt = "updated_at"
        case userID = "user_id"
        case billingAddress = "billing_address"
        case customer
        case discountApplications = "discount_applications"
        case fulfillments
        case lineItems = "line_items"
        case paymentDetails = "payment_details"
        case refunds
        case shippingAddress = "shipping_address"
        case shippingLines = "shipping_lines"
    }
}
// MARK: - LineItem
struct LineItemResponse: Codable {
    let id: Int
    let adminGraphqlAPIID: String
    let fulfillableQuantity: Int
    let fulfillmentService: String
    let fulfillmentStatus: JSONNull?
    let giftCard: Bool
    let grams: Int
    let name, price: String
    let priceSet: Set
    let productExists: Bool
    let productID: Int
    let properties: [JSONAny]
    let quantity: Int
    let requiresShipping: Bool
    let sku: String
    let taxable: Bool
    let title, totalDiscount: String
    let totalDiscountSet: Set
    let variantID: Int
    let variantInventoryManagement, variantTitle, vendor: String
    let taxLines, duties, discountAllocations: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case fulfillableQuantity = "fulfillable_quantity"
        case fulfillmentService = "fulfillment_service"
        case fulfillmentStatus = "fulfillment_status"
        case giftCard = "gift_card"
        case grams, name, price
        case priceSet = "price_set"
        case productExists = "product_exists"
        case productID = "product_id"
        case properties, quantity
        case requiresShipping = "requires_shipping"
        case sku, taxable, title
        case totalDiscount = "total_discount"
        case totalDiscountSet = "total_discount_set"
        case variantID = "variant_id"
        case variantInventoryManagement = "variant_inventory_management"
        case variantTitle = "variant_title"
        case vendor
        case taxLines = "tax_lines"
        case duties
        case discountAllocations = "discount_allocations"
    }
}
