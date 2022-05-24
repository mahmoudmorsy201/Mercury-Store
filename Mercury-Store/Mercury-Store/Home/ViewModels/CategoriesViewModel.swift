//
//  CategoriesViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 22/05/2022.
//

import RxSwift
import RxCocoa

protocol CategoriesViewModelType {
    var categories: Driver<[CategoryItem]> { get}
}

final class CategoriesViewModel: CategoriesViewModelType {
    private var categoriesSubject: PublishSubject = PublishSubject<[CategoryItem]>()
    var categories: Driver<[CategoryItem]>
    
    private var categoriesArray: [CategoryItem] = [
        CategoryItem(name: "Men", imageName: "Men", colorHex: "#642CA9"),
        CategoryItem(name: "Women", imageName: "Women", colorHex: "#FF36AB"),
        CategoryItem(name: "Kids", imageName: "Kids", colorHex: "#FF74D4"),
        CategoryItem(name: "Sale", imageName: "Sale", colorHex: "#FEB&DE")
    ]
    
    init() {
        categories = categoriesSubject.asDriver(onErrorJustReturn: [])
    }
    
    func getCategories() {
        categoriesSubject.onNext(categoriesArray)
    }
    
}
