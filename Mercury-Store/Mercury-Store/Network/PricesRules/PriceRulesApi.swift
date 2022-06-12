//
//  PriceRules.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 11/06/2022.
//

import Foundation
import Alamofire
enum PricesRules: URLRequestBuilder {
    case getPricesRules
}
extension PricesRules {
    var path: String {
        switch self {
        case .getPricesRules:
            return Constants.Paths.PricesRule.pricesRules
        }
    }
}

extension PricesRules {
    var parameters: Parameters? {
        switch self {
        case .getPricesRules:
            return [:]
        }
    }
}

extension PricesRules {
    var method: HTTPMethod {
        switch self {
        case .getPricesRules:
            return HTTPMethod.get
        }
    }
}

