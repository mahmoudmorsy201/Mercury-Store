//
//  OrdersAPI.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 10/06/2022.
//

import Foundation
import Alamofire

enum OrdersAPI: URLRequestBuilder {
    case getOrders(Int)
}
extension OrdersAPI {
    var path: String {
        switch self {
        case .getOrders:
            return Constants.Paths.Orders.ordersList
        }
    }
}

extension OrdersAPI {
    var parameters: Parameters? {
        switch self {
        case .getOrders(let value):
            return ["customer_id": value]
        }
    }
}

extension OrdersAPI {
    var method: HTTPMethod {
        switch self {
        case .getOrders(let id):
            return HTTPMethod.get
        }
    }
}

