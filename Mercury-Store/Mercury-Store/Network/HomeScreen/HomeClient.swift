//
//  HomeClient.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

import RxSwift

protocol BrandsProvider: AnyObject {
    func getBrandsCollection() -> Observable<SmartCollection>
}

protocol ProductsForBrandProvider: AnyObject {
    func getProductsForBrand(with id: Int) -> Observable<[Product]>
}

class HomeScreenAPI: BrandsProvider {
    func getBrandsCollection() -> Observable<SmartCollection> {
        NetworkService().execute(HomeScreenAPIs.getBrands)
    }
}

extension HomeScreenAPI: ProductsForBrandProvider {
    func getProductsForBrand(with id: Int) -> Observable<[Product]> {
        NetworkService().execute(HomeScreenAPIs.getProductsForBrand(id))
    }
}
