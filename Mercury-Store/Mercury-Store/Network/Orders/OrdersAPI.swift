//
//  OrdersAPI.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 10/06/2022.
//

import Foundation
import Alamofire

enum OrdersAPI: URLRequestBuilder {
    case getOrders
    case postOrder
}
extension OrdersAPI {
    var path: String {
        switch self {
        case .getOrders:
            return Constants.Paths.Customers.customerOrders
            
        case .postOrder:
            return Constants.Paths.Order.postOrder
        }
    }
}

extension OrdersAPI {
    var parameters: Parameters? {
        switch self {
        case .getOrders:
            return [:]
        case .postOrder:
            return [:]
        }
    }
}

extension OrdersAPI {
    var method: HTTPMethod {
        switch self {
        case .getOrders:
            return HTTPMethod.get
        case .postOrder:
            return HTTPMethod.post
        }
    }
}

