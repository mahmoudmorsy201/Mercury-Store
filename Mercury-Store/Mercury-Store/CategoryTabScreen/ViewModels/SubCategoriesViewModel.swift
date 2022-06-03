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
    var error: Driver<String?> { get }
    var categoryID:Int{ get set}
    var productTypes: Driver<[String]>{get}
}

final class SubCategoriesViewModel: CategoryProductsScreenViewModelType {
    private let categoryProvider: CategoriesProvider = CategoriesScreenAPI()
    private let disposeBag = DisposeBag()
    
    private let typesSubject = BehaviorRelay<[String]>(value: [])
    private let isLoadingSubject = BehaviorRelay<Bool>(value: false)
    private let errorSubject = BehaviorRelay<String?>(value: nil)
    
    var productTypes: Driver<[String]>
    
    var categoryID: Int{
        didSet{
            fetchData()
        }
    }
    
    var isLoading: Driver<Bool>
    
    var error: Driver<String?>
    
    init(categoryID:Int) {
        productTypes = typesSubject.asDriver(onErrorJustReturn: [])
        isLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)
        error = errorSubject.asDriver(onErrorJustReturn: "Something went wrong")
        self.categoryID = categoryID
    }
    private func fetchData() {
        self.isLoadingSubject.accept(true)
        self.errorSubject.accept(nil)
        self.categoryProvider.getCategoryProductsCollection(collectionID: categoryID)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {[weak self] (result) in
                self?.isLoadingSubject.accept(false)
                let types = self?.getProductTypes(items: result.products)
                self?.typesSubject.accept(types ?? [])
            } onError: {[weak self] (error) in
                self?.isLoadingSubject.accept(false)
                self?.errorSubject.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    private func getProductTypes(items:[Product])->[String]{
        let types:[String] = items.map { $0.productType.rawValue  }
        return types.unique
    }
    
}
