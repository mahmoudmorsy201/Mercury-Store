//
//  HomeScreenAPIs.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

import Alamofire

enum HomeScreenAPIs: URLRequestBuilder {
    case getBrands
    case getProductsForBrand(Int)
}

extension HomeScreenAPIs {
    var path: String {
        switch self {
        case .getBrands:
            return Constants.Paths.Brands.brandsList
        case .getProductsForBrand:
            return Constants.Paths.Products.productsListForBrand
        }
    }
}

extension HomeScreenAPIs {
    var parameters: Parameters? {
        switch self {
        case .getBrands:
            return [:]
        case .getProductsForBrand(let id):
            return ["collection_id" : id]
        }
    }
}

extension HomeScreenAPIs {
    var method: HTTPMethod {
        switch self {
        case .getBrands:
            return HTTPMethod.get
        case .getProductsForBrand:
            return HTTPMethod.get
        }
    }
}

