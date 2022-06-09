//
//  CustomerAPI.swift
//  Mercury-Store
//
//  Created by mac hub on 08/06/2022.
//

import Alamofire

enum CustomerAPI: URLRequestBuilder {
    case postCustomer(Customer)
    case getCustomer(Int)
    case editCustomer
}

extension CustomerAPI {
    var path: String {
        switch self {
        case .postCustomer:
            return Constants.Paths.Customers.customer
        case .getCustomer(let id):
            return "/customers/\(id).json"
        case .editCustomer:
            return Constants.Paths.Customers.customer
        }
    }
}

extension CustomerAPI {
    var parameters: Parameters? {
        switch self {
        case .postCustomer(let customer):
            return try! customer.asDictionary()
        case .getCustomer:
            return [:]
        case .editCustomer:
            return [:]
        }
    }
}

extension CustomerAPI {
    
    var method: HTTPMethod {
        switch self {
        case .postCustomer:
            return .post
        case .getCustomer:
            return .get
        case .editCustomer:
            return .put
        }
    }
}