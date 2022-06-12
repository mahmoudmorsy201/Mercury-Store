//
//  DraftOrders.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 10/06/2022.
//
import Foundation


/*
struct OrderList: Codable {
    let orders: [OrderItem]
}
// MARK: - Order
struct OrderItem: Codable {
    let id: Int
    let adminGraphqlAPIID: String
    let appID: JSONNull?
    let browserIP: String
    let buyerAcceptsMarketing: Bool
    let cancelReason, cancelledAt: JSONNull?
    let cartToken: String
    let checkoutID: Int
    let checkoutToken: String
    let clientDetails: ClientDetails
    let closedAt: JSONNull?
    let confirmed: Bool
    let contactEmail: String
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
    let discountCodes: [DiscountCode]
    let email: String
    let estimatedTaxes: Bool
    let financialStatus: String
    let fulfillmentStatus: JSONNull?
    let gateway: String
    let landingSite: String
    let landingSiteRef: String
    let locationID: JSONNull?
    let name: String
    let note: JSONNull?
    let noteAttributes: [NoteAttribute]
    let number, orderNumber: Int
    let orderStatusURL: String
    let originalTotalDutiesSet: JSONNull?
    let paymentGatewayNames: [String]
    let phone: String
    let presentmentCurrency: Currency
    let processedAt: Date
    let processingMethod, reference: String
    let referringSite: String
    let sourceIdentifier, sourceName: String
    let sourceURL: JSONNull?
    let subtotalPrice: String
    let subtotalPriceSet: Set
    let tags: String
    let taxLines: [TaxLine]
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
    let userID: JSONNull?
    let billingAddress: Address
    let customer: Customer
    let discountApplications: [DiscountApplication]
    let fulfillments: [Fulfillment]
    let lineItems: [LineItem]
    let paymentDetails: PaymentDetails
    let refunds: [Refund]
    let shippingAddress: Address
    let shippingLines: [ShippingLine]

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

// MARK: - ClientDetails
struct ClientDetails: Codable {
    let acceptLanguage, browserHeight: JSONNull?
    let browserIP: String
    let browserWidth, sessionHash, userAgent: JSONNull?

    enum CodingKeys: String, CodingKey {
        case acceptLanguage = "accept_language"
        case browserHeight = "browser_height"
        case browserIP = "browser_ip"
        case browserWidth = "browser_width"
        case sessionHash = "session_hash"
        case userAgent = "user_agent"
    }
}

enum Currency: String, Codable {
    case usd = "USD"
}

// MARK: - Set
struct Set: Codable {
    let shopMoney, presentmentMoney: Money

    enum CodingKeys: String, CodingKey {
        case shopMoney = "shop_money"
        case presentmentMoney = "presentment_money"
    }
}

// MARK: - Money
struct Money: Codable {
    let amount: String
    let currencyCode: String

    enum CodingKeys: String, CodingKey {
        case amount
        case currencyCode = "currency_code"
    }
}

// MARK: - Customer
struct CustomerOrder: Codable {
    let id: Int
    let email: String
    let acceptsMarketing: Bool
    let createdAt, updatedAt: Date
    let firstName, lastName, state: String
    let note: JSONNull?
    let verifiedEmail: Bool
    let multipassIdentifier: JSONNull?
    let taxExempt: Bool
    let phone, tags: String
    let currency: Currency
    let acceptsMarketingUpdatedAt: Date
    let marketingOptInLevel: JSONNull?
    let taxExemptions: [JSONAny]
    let emailMarketingConsent: EmailMarketingConsent
    let smsMarketingConsent, smsTransactionalConsent: JSONNull?
    let adminGraphqlAPIID: String
    let defaultAddress: Address

    enum CodingKeys: String, CodingKey {
        case id, email
        case acceptsMarketing = "accepts_marketing"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case state, note
        case verifiedEmail = "verified_email"
        case multipassIdentifier = "multipass_identifier"
        case taxExempt = "tax_exempt"
        case phone, tags, currency
        case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
        case marketingOptInLevel = "marketing_opt_in_level"
        case taxExemptions = "tax_exemptions"
        case emailMarketingConsent = "email_marketing_consent"
        case smsMarketingConsent = "sms_marketing_consent"
        case smsTransactionalConsent = "sms_transactional_consent"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case defaultAddress = "default_address"
    }
}

// MARK: - EmailMarketingConsent
struct EmailMarketingConsent: Codable {
    let state: String
    let optInLevel: JSONNull?
    let consentUpdatedAt: Date

    enum CodingKeys: String, CodingKey {
        case state
        case optInLevel = "opt_in_level"
        case consentUpdatedAt = "consent_updated_at"
    }
}

// MARK: - DiscountApplication
struct DiscountApplication: Codable {
    let targetType, type, value, valueType: String
    let allocationMethod, targetSelection, code: String

    enum CodingKeys: String, CodingKey {
        case targetType = "target_type"
        case type, value
        case valueType = "value_type"
        case allocationMethod = "allocation_method"
        case targetSelection = "target_selection"
        case code
    }
}

// MARK: - DiscountCode
struct DiscountCode: Codable {
    let code, amount, type: String
}

// MARK: - Fulfillment
struct Fulfillment: Codable {
    let id: Int
    let adminGraphqlAPIID: String
    let createdAt: Date
    let locationID: Int
    let name: String
    let orderID: Int
    let originAddress: OriginAddress
    let receipt: Receipt
    let service: String
    let shipmentStatus: String?
    let status, trackingCompany, trackingNumber: String
    let trackingNumbers: [String]
    let trackingURL: String
    let trackingUrls: [String]
    let updatedAt: Date
    let lineItems: [LineItem]

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case createdAt = "created_at"
        case locationID = "location_id"
        case name
        case orderID = "order_id"
        case originAddress = "origin_address"
        case receipt, service
        case shipmentStatus = "shipment_status"
        case status
        case trackingCompany = "tracking_company"
        case trackingNumber = "tracking_number"
        case trackingNumbers = "tracking_numbers"
        case trackingURL = "tracking_url"
        case trackingUrls = "tracking_urls"
        case updatedAt = "updated_at"
        case lineItems = "line_items"
    }
}

// MARK: - LineItem
struct LineItem: Codable {
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
    let properties: [NoteAttribute]
    let quantity: Int
    let requiresShipping: Bool
    let sku: String
    let taxable: Bool
    let title, totalDiscount: String
    let totalDiscountSet: Set
    let variantID: Int
    let variantInventoryManagement, variantTitle: String
    let vendor: JSONNull?
    let taxLines: [TaxLine]
    let duties: [JSONAny]
    let discountAllocations: [DiscountAllocation]

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

// MARK: - DiscountAllocation
struct DiscountAllocation: Codable {
    let amount: String
    let amountSet: Set
    let discountApplicationIndex: Int

    enum CodingKeys: String, CodingKey {
        case amount
        case amountSet = "amount_set"
        case discountApplicationIndex = "discount_application_index"
    }
}

// MARK: - NoteAttribute
struct NoteAttribute: Codable {
    let name, value: String
}

// MARK: - TaxLine
struct TaxLine: Codable {
    let channelLiable: Bool?
    let price: String
    let priceSet: Set
    let rate: Double
    let title: String

    enum CodingKeys: String, CodingKey {
        case channelLiable = "channel_liable"
        case price
        case priceSet = "price_set"
        case rate, title
    }
}

// MARK: - OriginAddress
struct OriginAddress: Codable {
}

// MARK: - Receipt
struct Receipt: Codable {
    let testcase: Bool
    let authorization: String
}

// MARK: - PaymentDetails
struct PaymentDetails: Codable {
    let creditCardBin, avsResultCode, cvvResultCode: JSONNull?
    let creditCardNumber, creditCardCompany: String
    let creditCardName, creditCardWallet, creditCardExpirationMonth, creditCardExpirationYear: JSONNull?

    enum CodingKeys: String, CodingKey {
        case creditCardBin = "credit_card_bin"
        case avsResultCode = "avs_result_code"
        case cvvResultCode = "cvv_result_code"
        case creditCardNumber = "credit_card_number"
        case creditCardCompany = "credit_card_company"
        case creditCardName = "credit_card_name"
        case creditCardWallet = "credit_card_wallet"
        case creditCardExpirationMonth = "credit_card_expiration_month"
        case creditCardExpirationYear = "credit_card_expiration_year"
    }
}

// MARK: - Refund
struct Refund: Codable {
    let id: Int
    let adminGraphqlAPIID: String
    let createdAt: Date
    let note: String
    let orderID: Int
    let processedAt: Date
    let restock: Bool
    let totalAdditionalFeesSet, totalDutiesSet: Set
    let userID: Int
    let orderAdjustments: [JSONAny]
    let transactions: [Transaction]
    let refundLineItems: [RefundLineItem]
    let duties, additionalFees: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case createdAt = "created_at"
        case note
        case orderID = "order_id"
        case processedAt = "processed_at"
        case restock
        case totalAdditionalFeesSet = "total_additional_fees_set"
        case totalDutiesSet = "total_duties_set"
        case userID = "user_id"
        case orderAdjustments = "order_adjustments"
        case transactions
        case refundLineItems = "refund_line_items"
        case duties
        case additionalFees = "additional_fees"
    }
}

// MARK: - RefundLineItem
struct RefundLineItem: Codable {
    let id, lineItemID, locationID, quantity: Int
    let restockType: String
    let subtotal: Double
    let subtotalSet: Set
    let totalTax: Double
    let totalTaxSet: Set
    let lineItem: LineItem

    enum CodingKeys: String, CodingKey {
        case id
        case lineItemID = "line_item_id"
        case locationID = "location_id"
        case quantity
        case restockType = "restock_type"
        case subtotal
        case subtotalSet = "subtotal_set"
        case totalTax = "total_tax"
        case totalTaxSet = "total_tax_set"
        case lineItem = "line_item"
    }
}

// MARK: - Transaction
struct Transaction: Codable {
    let id: Int
    let adminGraphqlAPIID, amount, authorization: String
    let createdAt: Date
    let currency: Currency
    let deviceID, errorCode: JSONNull?
    let gateway, kind: String
    let locationID, message: JSONNull?
    let orderID, parentID: Int
    let processedAt: Date
    let receipt: OriginAddress
    let sourceName, status: String
    let test: Bool
    let userID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case amount, authorization
        case createdAt = "created_at"
        case currency
        case deviceID = "device_id"
        case errorCode = "error_code"
        case gateway, kind
        case locationID = "location_id"
        case message
        case orderID = "order_id"
        case parentID = "parent_id"
        case processedAt = "processed_at"
        case receipt
        case sourceName = "source_name"
        case status, test
        case userID = "user_id"
    }
}

// MARK: - ShippingLine
struct ShippingLine: Codable {
    let id: Int
    let carrierIdentifier: JSONNull?
    let code: String
    let deliveryCategory: JSONNull?
    let discountedPrice: String
    let discountedPriceSet: Set
    let phone: JSONNull?
    let price: String
    let priceSet: Set
    let requestedFulfillmentServiceID: JSONNull?
    let source, title: String
    let taxLines, discountAllocations: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case carrierIdentifier = "carrier_identifier"
        case code
        case deliveryCategory = "delivery_category"
        case discountedPrice = "discounted_price"
        case discountedPriceSet = "discounted_price_set"
        case phone, price
        case priceSet = "price_set"
        case requestedFulfillmentServiceID = "requested_fulfillment_service_id"
        case source, title
        case taxLines = "tax_lines"
        case discountAllocations = "discount_allocations"
    }
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

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}*/

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let customerEditResonse = try? newJSONDecoder().decode(CustomerEditResonse.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCustomerEditResonse { response in
//     if let customerEditResonse = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - CustomerEditResonse
struct DraftOrderResponseTest: Codable {
    let draftOrder: DraftOrderTest

    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDraftOrder { response in
//     if let draftOrder = response.result.value {
//       ...
//     }
//   }

// MARK: - DraftOrder
struct DraftOrderTest: Codable {
    let id: Int
    let note: String?
    let email: String
    let taxesIncluded: Bool
    let currency: String
    //let invoiceSentAt: JSONNull?
    let createdAt, updatedAt: Date
    let taxExempt: Bool
    //let completedAt: JSONNull?
    let name, status: String
    let lineItems: [LineItem]
    //let shippingAddress, billingAddress: JSONNull?
    let invoiceURL: String
    //let appliedDiscount, orderID, shippingLine: JSONNull?
    let taxLines: [TaxLine]
    let tags: String
    //let noteAttributes: [JSONAny]
    let totalPrice, subtotalPrice, totalTax: String
    //let paymentTerms: JSONNull?
    let adminGraphqlAPIID: String
    let customer: CustomerDraftTest

    enum CodingKeys: String, CodingKey {
        case id, note, email
        case taxesIncluded = "taxes_included"
        case currency
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxExempt = "tax_exempt"
        case name, status
        case lineItems = "line_items"
        case invoiceURL = "invoice_url"
        case taxLines = "tax_lines"
        case tags
        case totalPrice = "total_price"
        case subtotalPrice = "subtotal_price"
        case totalTax = "total_tax"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case customer
    }
}


// MARK: - Customer
struct CustomerDraftTest: Codable {
    let id: Int
    let email: String
    let acceptsMarketing: Bool
    let createdAt, updatedAt: Date
    let firstName, lastName: String
    let ordersCount: Int
    let state, totalSpent: String
    let lastOrderID: Int?
    let note: String
    let verifiedEmail: Bool
    let multipassIdentifier: String
    let taxExempt: Bool
    let phone: String?
    let tags: String
    let lastOrderName: String?
    let currency: String
    let acceptsMarketingUpdatedAt: Date
    //let marketingOptInLevel: JSONNull?
    //let taxExemptions: [JSONAny]
    let emailMarketingConsent: EmailMarketingConsent
    //let smsMarketingConsent: JSONNull?
    let adminGraphqlAPIID: String

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
        case multipassIdentifier = "multipass_identifier"
        case taxExempt = "tax_exempt"
        case phone, tags
        case lastOrderName = "last_order_name"
        case currency
        case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
        case emailMarketingConsent = "email_marketing_consent"
        case adminGraphqlAPIID = "admin_graphql_api_id"
    }
}


// MARK: - EmailMarketingConsent
struct EmailMarketingConsent: Codable {
    let state, optInLevel: String
    //let consentUpdatedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case state
        case optInLevel = "opt_in_level"
    }
}


// MARK: - LineItem
struct LineItem: Codable {
    let id, variantID, productID: Int
    let title, variantTitle, sku, vendor: String
    let quantity: Int
    let requiresShipping, taxable, giftCard: Bool
    let fulfillmentService: String
    let grams: Int
    let taxLines: [TaxLine]
    //let appliedDiscount: JSONNull?
    let name: String
    //let properties: [JSONAny]
    let custom: Bool
    let price, adminGraphqlAPIID: String

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
        case fulfillmentService = "fulfillment_service"
        case grams
        case taxLines = "tax_lines"
        case name, custom, price
        case adminGraphqlAPIID = "admin_graphql_api_id"
    }
}


// MARK: - TaxLine
struct TaxLine: Codable {
    let rate: Double
    let title, price: String
}
