
//
//  ProductSearchViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 04/06/2022.
//

import Foundation
import RxCocoa
import RxSwift


struct SearchInput {
    let viewLoaded: Observable<[Product]>
    let filterTapped: Observable<Void>
    let sortTapped: Observable<Void>
}

struct SearchOutput {
    let filteredItems: Observable<[SearchSection]>
}

final class ProductSearchViewModel {
    private weak var searchFlowNavigation : SearchFlowNavigation?
    private let provider: SearchProvider
    
    private let disposeBag = DisposeBag()
    private let searchBarBehavior = BehaviorSubject<String?>(value: "")
    private let sliderBehavior = BehaviorSubject<Float>(value: 0)
    private let sortBehavior = BehaviorSubject<Bool> ( value: false)
    private let productListSubject = PublishSubject<[Product]>()
    
    var searchByName: AnyObserver<String?> { searchBarBehavior.asObserver()}
    
    var valueChanged: Observable<[Product]> { productListSubject.asObservable() }
    let value = BehaviorRelay<Int>(value:0)
    var searchByPrice: AnyObserver<Float> {
        sliderBehavior.asObserver()
    }
    
    var sortAlphabetically: AnyObserver<Bool> {
        sortBehavior.asObserver()
    }
    
    func bind(_ input: SearchInput) -> SearchOutput {
        let search = Observable.merge(
            filterArrayBasedOnSearch(),
            filterArrayBasedOnSlider()
            //valueChanged.map { SearchAction.viewIsLoaded($0)}
        )
        return SearchOutput(filteredItems: search)
    }
    
    init(provider: SearchProvider = SearchClient(),searchFlowNavigation : SearchFlowNavigation) {
        self.provider = provider
        self.searchFlowNavigation = searchFlowNavigation
    }
    
    func filterArrayBasedOnSearch() -> Observable<[SearchSection]> {
        Observable.combineLatest(
            searchBarBehavior
                .map { $0 ?? "" }
                .startWith("")
                .throttle(.milliseconds(500), scheduler: MainScheduler.instance),
            productListSubject
        )
        .map { searchValue, products in
            searchValue.isEmpty ? products : products.filter { $0.title.lowercased().contains(searchValue.lowercased()) }
        }.map { values in
            [SearchSection(values)]
        }
    }
    func filterArrayBasedOnSlider() -> Observable<[SearchSection]>{
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
        }.map { values in
            [SearchSection(values)]
        }
    }
    
    func fetchData() {
        //self.isLoadingSubject.accept(true)
        self.provider.getProductsList()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {[weak self] (result) in
                self?.productListSubject.onNext(result.products)
                //Repository.item = result.products
                //print(self?.item)
//                self?.isLoadingSubject.accept(false)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}


/*
class Repository {
    private let disposeBag = DisposeBag()
    private let provider: SearchProvider
    private let productListSubject = PublishSubject<[Product]>()
    
    var valueChanged: AnyObserver<[Product]> { productListSubject.asObserver() }
    
    init(provider: SearchProvider = SearchClient()) {
        self.provider = provider
    }
    func fetchData() {
        //self.isLoadingSubject.accept(true)
        self.provider.getProductsList()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {[weak self] (result) in
                self?.productListSubject.onNext(result.products)
                //Repository.item = result.products
                //print(self?.item)
//                self?.isLoadingSubject.accept(false)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}




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
 
 func bind(_ input: SearchInput) -> SearchOutput {
     let search = Observable.merge(
         searchBarBehavior.map { SearchAction.searchByName($0 ?? "")},
         sliderBehavior.map { SearchAction.searchByPrice($0)},
         sortBehavior.map{ SearchAction.sortAlphabetically($0)},
         valueChanged.map { SearchAction.viewIsLoaded($0)}
     )
         .scan(SearchState.empty()) { state, action in
             state.execute(action)
         }
         .map{ $0.sections}
         .share(replay: 1, scope: .forever)
     return SearchOutput(filteredItems: search)
 }



 */
