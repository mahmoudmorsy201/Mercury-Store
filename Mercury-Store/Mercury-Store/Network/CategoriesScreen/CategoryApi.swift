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
    case getFilteredProduct(Int ,String)
}
extension CategoryScreenAPIs {
    var path: String {
        switch self {
        case .getCategories:
            return Constants.Pathes.Categories.mainCategoryList
        case .getProducts , .getFilteredProduct:
            return Constants.Pathes.Products.productList
        }
    }
}

extension CategoryScreenAPIs {
    var parameters: Parameters? {
        switch self {
        case .getCategories:
            return [:]
        case .getFilteredProduct(let  value, let second):
            return ["collection_id": value, "product_type": second]
        case .getProducts(let value):
            return ["collection_id": value]
        }
    }
}

extension CategoryScreenAPIs {
    var method: HTTPMethod {
        switch self {
        case .getCategories , .getFilteredProduct(_, _) , .getProducts:
            return HTTPMethod.get
        }
    }
}

