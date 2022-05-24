//
//  BrandsViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 22/05/2022.
//

import RxSwift
import RxCocoa


protocol BrandsViewModelType {
    var isLoading: Driver<Bool> { get }
    var brands: Driver<[SmartCollectionElement]> { get}
    var error: Driver<String?> { get }
}

final class BrandsViewModel: BrandsViewModelType {
    
    private let brandsProvider: BrandsProvider
    private let disposeBag = DisposeBag()
    
    private let brandsSubject = BehaviorRelay<[SmartCollectionElement]>(value: [])
    private let isLoadingSubject = BehaviorRelay<Bool>(value: false)
    private let errorSubject = BehaviorRelay<String?>(value: nil)
    
    var isLoading: Driver<Bool>
    
    var brands: Driver<[SmartCollectionElement]>
    
    var error: Driver<String?>
    
    init(brandsProvider: BrandsProvider) {
        brands = brandsSubject.asDriver(onErrorJustReturn: [])
        isLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)
        error = errorSubject.asDriver(onErrorJustReturn: "Somthing went wrong")
        self.brandsProvider = brandsProvider
        self.fetchData()
        
    }
    
    private func fetchData() {
        self.brandsSubject.accept([])
        self.isLoadingSubject.accept(true)
        self.errorSubject.accept(nil)
        self.brandsProvider.getBrandsCollection()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {[weak self] (result) in
                self?.isLoadingSubject.accept(false)
                self?.brandsSubject.accept(result.smartCollections)
            } onError: {[weak self] (error) in
                self?.isLoadingSubject.accept(false)
                self?.errorSubject.accept(error.localizedDescription)
            }.disposed(by: disposeBag)

    }
    
    
}
