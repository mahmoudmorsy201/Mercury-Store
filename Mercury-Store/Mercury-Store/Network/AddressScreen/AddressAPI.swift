//
//  AddressApI.swift
//  Mercury-Store
//
//  Created by mac hub on 13/06/2022.
//

import Foundation
import Alamofire

enum AddressAPI: URLRequestBuilder {
    case postAddress(Int,AddressRequest)
    case getAddress(Int)
}

extension AddressAPI {
    var path: String {
        switch self {
        case .postAddress(let id, _):
            return "/customers/\(id)/addresses.json"
        case .getAddress(let id):
            return  "/customers/\(id)/addresses.json"
        }
    }
}

extension AddressAPI {
    var parameters: Parameters? {
        switch self {
        case .postAddress(_, let addressRequest):
            return try! addressRequest.asDictionary()
        case .getAddress(let id):
            return [:]
            
        }
    }
}

extension AddressAPI {
    var method: HTTPMethod {
        switch self {
        case .postAddress:
            return .post
       case .getAddress:
            return .get
        }
    }
}
