//
//  CategoriesViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 22/05/2022.
//

import RxSwift
import RxCocoa

protocol CategoriesViewModelType {
    var categories: Driver<[CategoryDataItem]> { get}
}

final class CategoriesViewModel: CategoriesViewModelType {
    private var categoriesSubject: PublishSubject = PublishSubject<[CategoryDataItem]>()
    var categories: Driver<[CategoryDataItem]>
    
    private var categoriesArray: [CategoryDataItem] = [
        CategoryDataItem(name: "Men", imageName: "Men", colorHex: "#642CA9"),
        CategoryDataItem(name: "Women", imageName: "Women", colorHex: "#FF36AB"),
        CategoryDataItem(name: "Kids", imageName: "Kids", colorHex: "#FF74D4"),
        CategoryDataItem(name: "Sale", imageName: "Sale", colorHex: "#FEB&DE")
    ]
    
    init() {
        categories = categoriesSubject.asDriver(onErrorJustReturn: [])
    }
    
    func getCategories() {
        categoriesSubject.onNext(categoriesArray)
    }
    
}
