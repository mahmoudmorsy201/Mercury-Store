//
//  SearchClient.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 04/06/2022.
//

import Foundation
import RxSwift

protocol SearchProvider: AnyObject {
    func getProductsList() -> Observable<ProductsCategory>
   
}
class SearchClient: SearchProvider {
    
    func getProductsList() -> Observable<ProductsCategory> {
        NetworkService().execute(SearchApi.getProducts)
    }
}

