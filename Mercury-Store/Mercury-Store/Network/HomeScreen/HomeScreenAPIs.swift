//
//  HomeScreenAPIs.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

import Alamofire

enum HomeScreenAPIs: URLRequestBuilder {
    case getBrands
}

extension HomeScreenAPIs {
    var path: String {
        switch self {
        case .getBrands:
            return Constants.Pathes.Brands.brandsList
        }
    }
}

extension HomeScreenAPIs {
    var parameters: Parameters? {
        switch self {
        case .getBrands:
            return [:]
        }
    }
}

extension HomeScreenAPIs {
    var method: HTTPMethod {
        switch self {
        case .getBrands:
            return HTTPMethod.get
        }
    }
}

