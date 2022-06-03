//
//  BrandDetailsViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 03/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol BrandDetailsViewModelType: AnyObject {
    var item: SmartCollectionElement { get }
    var isLoading: Driver<Bool> { get }
    var productsForBrand: Driver<[Product]> { get }
    var error: Driver<String?> { get }
}

final class BrandDetailsViewModel: BrandDetailsViewModelType {
    
    private let productsForBrandSubject = BehaviorRelay<[Product]>(value: [])
    private let isLoadingSubject = BehaviorRelay<Bool> (value: false)
    
    private let errorSubject = BehaviorRelay<String?> (value: nil)
    
    var item: SmartCollectionElement
    
    var isLoading: Driver<Bool>
    
    var productsForBrand: Driver<[Product]>
    
    var error: Driver<String?>
    
    
    init(with model: SmartCollectionElement) {
        productsForBrand = productsForBrandSubject.asDriver(onErrorJustReturn: [])
        isLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)
        error = errorSubject.asDriver(onErrorJustReturn: "Something went wrong")
        self.item = model
    }
    
    func fetchData() {
        self.productsForBrandSubject.accept([])
        self.isLoadingSubject.accept(true)
        self.errorSubject.accept(nil)
        
        
        
    }
}


