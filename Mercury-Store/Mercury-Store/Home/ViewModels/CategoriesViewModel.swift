//
//  CategoriesViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 22/05/2022.
//

import RxSwift


struct CategoriesViewModel {
    let categroies = BehaviorSubject<[CategoryItem]> (value: [])
    
    init(categories: [CategoryItem]) {
        self.categroies.onNext(categories)
    }
}
