//
//  CategoryViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//
import Foundation
import RxSwift
import RxCocoa

protocol CategoriesScreenViewModelType {
    var isLoading: Driver<Bool> { get }
    var categories: Driver<[CustomCollection]> { get}
    var error: Driver<String?> { get }
}

final class CategoriesScreenViewModel: CategoriesScreenViewModelType {
    
    private let categoryProvider: CategoriesProvider = CategoriesScreenAPI()
    private let disposeBag = DisposeBag()
    
    private let categorySubject = BehaviorRelay<[CustomCollection]>(value: [])
    private let isLoadingSubject = BehaviorRelay<Bool>(value: false)
    private let errorSubject = BehaviorRelay<String?>(value: nil)
    
    var isLoading: Driver<Bool>
    
    var categories: Driver<[CustomCollection]>
    
    var error: Driver<String?>
    
    init() {
        categories = categorySubject.asDriver(onErrorJustReturn: [])
        isLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)
        error = errorSubject.asDriver(onErrorJustReturn: "Somthing went wrong")
        self.fetchData()
    }
    private func fetchData() {
        print("fetch data")
        self.categorySubject.accept([])
        self.isLoadingSubject.accept(true)
        self.errorSubject.accept(nil)
        self.categoryProvider.getCategoriesCollection()
            .observe(on: MainScheduler.asyncInstance)
                    .subscribe {[weak self] (result) in
                        self?.isLoadingSubject.accept(false)
                        self?.categorySubject.accept(result.customCollections)
                        print(result)
                    } onError: {[weak self] (error) in
                        self?.isLoadingSubject.accept(false)
                        self?.errorSubject.accept(error.localizedDescription)
                        print(error)
                    }.disposed(by: disposeBag)
    }
    
    
}
