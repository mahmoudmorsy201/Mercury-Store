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
    case getCustomerByEmail(String)
}

extension CustomerAPI {
    var path: String {
        switch self {
        case .postCustomer, .editCustomer, .getCustomer:
            return Constants.Paths.Customers.customer
            
            
            
        case .getCustomerByEmail:
            return Constants.Paths.Customers.customerSearch
        }
    }
}

extension CustomerAPI {
    var parameters: Parameters? {
        switch self {
        case .postCustomer(let customer):
            return try! customer.asDictionary()
        case .getCustomer(let int):
            return [:]
        case .editCustomer:
            return [:]
        case .getCustomerByEmail(let email):
            
            return ["query": "email:\(email)"]
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
        case .getCustomerByEmail:
            return .get
        }
    }
}
