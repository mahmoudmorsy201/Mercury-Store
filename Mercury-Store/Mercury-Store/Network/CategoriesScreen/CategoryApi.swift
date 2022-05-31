//
//  CategoryApi.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 27/05/2022.
//

import Foundation
import Alamofire

enum CategoryScreenAPIs: URLRequestBuilder {
    case getCategories
    case getProducts(Int)
}

extension CategoryScreenAPIs {
    var path: String {
        switch self {
        case .getCategories:
            return Constants.Pathes.Categories.mainCategoryList
        case .getProducts:
            return Constants.Pathes.Products.productList
        }
    }
}

extension CategoryScreenAPIs {
    var parameters: Parameters? {
        switch self {
        case .getCategories:
            return [:]
        case .getProducts(let  value):
            return ["collection_id": value]
        }
    }
}

extension CategoryScreenAPIs {
    var method: HTTPMethod {
        switch self {
        case .getCategories:
            return HTTPMethod.get
        case .getProducts:
            return HTTPMethod.get
        }
    }
}

