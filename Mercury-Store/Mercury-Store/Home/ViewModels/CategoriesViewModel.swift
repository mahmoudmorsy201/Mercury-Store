//
//  CategoriesViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 22/05/2022.
//

import RxSwift
import RxCocoa

protocol CategoriesViewModelType {
    var categories: Driver<[CategoryDataItem]> { get }
    func goToFilteredProductScreen(with id: Int)
}

final class CategoriesViewModel: CategoriesViewModelType {
    private weak var homeNavigationFlow: HomeFlowNavigation?
    private var categoriesSubject: PublishSubject = PublishSubject<[CategoryDataItem]>()
    var categories: Driver<[CategoryDataItem]>
    
    private var categoriesArray: [CategoryDataItem] = [
        CategoryDataItem(id: 395727569125, name: "Home", imageName: "home", colorHex: "FEDDE1"),
        CategoryDataItem(id: 395728126181, name: "Men", imageName: "Men", colorHex: "#642CA9"),
        CategoryDataItem(id: 395728158949, name: "Women", imageName: "Women", colorHex: "#FF36AB"),
        CategoryDataItem(id: 395728191717, name: "Kids", imageName: "Kids", colorHex: "#FF74D4"),
        CategoryDataItem(id: 395728224485, name: "Sale", imageName: "Sale", colorHex: "#FEB&DE")
    ]
    
    init(with homeFlowNavigation: HomeFlowNavigation) {
        categories = categoriesSubject.asDriver(onErrorJustReturn: [])
        self.homeNavigationFlow = homeFlowNavigation
    }
    
    func getCategories() {
        categoriesSubject.onNext(categoriesArray)
    }
    
    func goToFilteredProductScreen(with id: Int) {
        homeNavigationFlow?.goToFilteredProduct(with: id)
    }
    
}
