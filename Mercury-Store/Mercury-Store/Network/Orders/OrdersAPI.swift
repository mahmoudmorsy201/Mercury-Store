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
    case postOrder(DraftOrdersRequest)
    case modifyExistingOrder(Int, PutOrderRequest)
}
extension OrdersAPI {
    var path: String {
        switch self {
        case .getOrders(let id):
            return Constants.Paths.Customers.customerOrders + "/\(id)/orders.json"
            
        case .postOrder:
            return Constants.Paths.Order.postOrder
        case .modifyExistingOrder(let id, _):
            return Constants.Paths.Order.modifyExistingOrder + "/\(id).json"
        }
    }
}

extension OrdersAPI {
    var parameters: Parameters? {
        switch self {
        case .getOrders:
            return [:]
        case .postOrder(let order):
            return try! order.asDictionary()
        case .modifyExistingOrder(_, let order):
            return try! order.asDictionary()
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
        case .modifyExistingOrder:
            return .put
        }
    }
}

