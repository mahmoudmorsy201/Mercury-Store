
//
//  ProductSearchViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 04/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

class ProductSearchViewModel {
    
    private weak var searchFlowNavigation : SearchFlowNavigation?
    private let provider: SearchProvider
    private let productListSubject = PublishSubject<[Product]>()
    
    private let searchValueBehavior = BehaviorSubject<String?>(value: "")
    private let disposeBag = DisposeBag()
    private let isLoadingSubject = BehaviorRelay<Bool> (value: false)
    
    let value = BehaviorRelay<Int>(value:0)
    var isLoadingData: Driver<Bool>
    
    var searchValueObserver: AnyObserver<String?> { searchValueBehavior.asObserver() }
    var filteredProductList: Observable<[Product]>
    
    init(provider: SearchProvider = SearchClient(),searchFlowNavigation : SearchFlowNavigation) {
        self.provider = provider
        self.searchFlowNavigation = searchFlowNavigation
        isLoadingData = isLoadingSubject.asDriver(onErrorJustReturn: false)
        
        filteredProductList = Observable.combineLatest(
            searchValueBehavior
                .map { $0 ?? "" }
                .startWith("")
                .throttle(.milliseconds(500), scheduler: MainScheduler.instance),
            productListSubject
        )
        .map { searchValue, products in
            searchValue.isEmpty ? products : products.filter { $0.title.lowercased().contains(searchValue.lowercased()) }
        }
    }
    func filterArrayBasedOnSearch() -> Observable<[Product]> {
        Observable.combineLatest(
            searchValueBehavior
                .map { $0 ?? "" }
                .startWith("")
                .throttle(.milliseconds(500), scheduler: MainScheduler.instance),
            productListSubject
        )
        .map { searchValue, products in
            searchValue.isEmpty ? products : products.filter { $0.title.lowercased().contains(searchValue.lowercased()) }
        }
    }
    func filterArrayBasedOnSlider() -> Observable<[Product]>{
        return Observable.combineLatest(
            value
                .map{ $0 }
                .startWith(0)
                .throttle(.microseconds(500), scheduler: MainScheduler.instance),
            productListSubject
        )
        .map { searchValue, products in
            searchValue == 0 ? products : products.filter {
                $0.variants[0].price.contains("\(searchValue)")
            }
        }
    }
    
    func fetchData() {
        self.isLoadingSubject.accept(true)
        self.provider.getProductsList()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {[weak self] (result) in
                self?.productListSubject.onNext(result.products)
                self?.isLoadingSubject.accept(false)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
    
    
    func goToProductDetailFromSearch(with item:Product) {
        
        searchFlowNavigation?.goToProductDetailFromSearch(with: item)
        
    }
}


