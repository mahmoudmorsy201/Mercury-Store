//
//  CategoryViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//
import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol CategoryProductsScreenViewModelType {
    var isLoading: Driver<Bool> { get }
    var products: Driver<[Product]> { get}
    var error: Driver<String?> { get }
}

final class CategoryProductsScreenViewModel: CategoryProductsScreenViewModelType {
    var isLoading: Driver<Bool>
    
    var products: Driver<[Product]>
    
    var error: Driver<String?>
    
    private let categoryProvider: CategoriesProvider = CategoriesScreenAPI()
    private let disposeBag = DisposeBag()
    
    private let categorySubject = BehaviorRelay<[Product]>(value: [])
    private let isLoadingSubject = BehaviorRelay<Bool>(value: false)
    private let errorSubject = BehaviorRelay<String?>(value: nil)
    
    
    init(categoryID:Int) {
        products = categorySubject.asDriver(onErrorJustReturn: [])
        isLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)
        error = errorSubject.asDriver(onErrorJustReturn: "Somthing went wrong")
        self.fetchData(categoryID: categoryID)
    }
    private func fetchData(categoryID:Int) {
        self.categorySubject.accept([])
        self.isLoadingSubject.accept(true)
        self.errorSubject.accept(nil)
        self.categoryProvider.getCategoryProductsCollection(collectionID: categoryID)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {[weak self] (result) in
                self?.isLoadingSubject.accept(false)
                self?.categorySubject.accept(result.products)
            } onError: {[weak self] (error) in
                self?.isLoadingSubject.accept(false)
                self?.errorSubject.accept(error.localizedDescription)
            }.disposed(by: disposeBag)

    }
    
    
}
