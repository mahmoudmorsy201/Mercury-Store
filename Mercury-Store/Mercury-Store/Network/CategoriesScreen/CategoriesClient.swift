//
//  CategoriesClient.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 27/05/2022.
//
import RxSwift

protocol CategoriesProvider: AnyObject {
    func getCategoriesCollection() -> Observable<SmartCollection>
    func getCategoryProductsCollection(collectionID:Int) -> Observable<ProductsCategory>
}

class CategoriesScreenAPI: CategoriesProvider {
    
    func getCategoryProductsCollection(collectionID:Int) -> Observable<ProductsCategory> {
        NetworkService.execute(CategoryScreenAPIs.getProducts(collectionID))
    }
    
    func getCategoriesCollection() -> Observable<SmartCollection> {
        NetworkService.execute(CategoryScreenAPIs.getCategories)
    }
}
