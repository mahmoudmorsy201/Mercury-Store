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

class HomeScreenAPI: BrandsProvider {
    func getBrandsCollection() -> Observable<SmartCollection> {
        NetworkService.execute(HomeScreenAPIs.getBrands)
    }
}
