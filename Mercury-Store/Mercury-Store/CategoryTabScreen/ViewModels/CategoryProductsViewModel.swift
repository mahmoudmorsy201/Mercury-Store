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
    var categoryID:Int{ get set}
    var getDestinctType:Bool{get set}
    var productTypes: Driver<[String]>{get}
}

final class CategoryProductsScreenViewModel: CategoryProductsScreenViewModelType {
    var productTypes: Driver<[String]>
    
    var categoryID: Int{
        didSet{
            fetchData()
        }
    }
    
    var isLoading: Driver<Bool>
    
    var products: Driver<[Product]>
    
    var error: Driver<String?>
    
    private let categoryProvider: CategoriesProvider = CategoriesScreenAPI()
    private let disposeBag = DisposeBag()
    
    private let categorySubject = BehaviorRelay<[Product]>(value: [])
    private let typesSubject = BehaviorRelay<[String]>(value: [])
    private let isLoadingSubject = BehaviorRelay<Bool>(value: false)
    private let errorSubject = BehaviorRelay<String?>(value: nil)
    var getDestinctType:Bool = false
    
    init(categoryID:Int) {
        products = categorySubject.asDriver(onErrorJustReturn: [])
        productTypes = typesSubject.asDriver(onErrorJustReturn: [])
        isLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)
        error = errorSubject.asDriver(onErrorJustReturn: "Somthing went wrong")
        self.categoryID = categoryID
    }
    private func fetchData() {
        self.categorySubject.accept([])
        self.isLoadingSubject.accept(true)
        self.errorSubject.accept(nil)
        self.categoryProvider.getCategoryProductsCollection(collectionID: categoryID)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {[weak self] (result) in
                self?.isLoadingSubject.accept(false)
                if(self?.getDestinctType == true){
                    let types = self?.getProductTypes(items: result.products)
                    self?.typesSubject.accept(types ?? [])
                }else{
                    self?.categorySubject.accept(result.products)
                }
            } onError: {[weak self] (error) in
                self?.isLoadingSubject.accept(false)
                self?.errorSubject.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func getProductTypes(items:[Product])->[String]{
        let types:[String] = items.map { $0.productType.rawValue  }
        types.unique.forEach{ print($0) }
        return types.unique
    }
    
}
