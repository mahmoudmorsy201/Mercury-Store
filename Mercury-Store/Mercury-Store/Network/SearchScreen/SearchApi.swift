//
//  SearchApi.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 04/06/2022.
//

import Alamofire

enum SearchApi: URLRequestBuilder {
    case getProducts
}

extension SearchApi {
    
    var path : String {
        switch self {
            
        case .getProducts:
            return Constants.Paths.Products.productList
        }
        
    }
}

extension SearchApi {
    
    var parameters: Parameters? {
        switch self {
        
        case .getProducts:
            return [:]
        }
    }
}
extension SearchApi {
    
    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }
}
