
//
//  ProductSearchViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 04/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

class ProductSearchViewModel: SearchViewModel<Product> {
    private let provider: SearchProvider
    private let productListSubject = PublishSubject<[Product]>()
    private let disposeBag = DisposeBag()
    private var items: [Product] = []
    private weak var searchFlowNavigation : SearchFlowNavigation?
    
    init(provider: SearchProvider = SearchClient(),searchFlowNavigation : SearchFlowNavigation) {
        self.provider = provider
        self.searchFlowNavigation = searchFlowNavigation
        
    }
    
    func fetchData() {
        self.provider.getProductsList()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {[weak self] (result) in
                self?.productListSubject.onNext(result.products)
                self?.items = result.products
            } onError: { error in
                print(error)
                
            }.disposed(by: disposeBag)
    }
    
    override func search(byTerm term: String) -> Observable<[Product]> {
        let filteredProducts = items.filter { $0.title[$0.title.startIndex] == term[term.startIndex] }
        
        return Observable.create({ (observer) -> Disposable in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if filteredProducts.isEmpty {
                    observer.onError(SearchError.notFound)
                } else {
                    observer.onNext(filteredProducts)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        })
    }
    
    func goToProductDetailFromSearch(with item:Product) {
        
        searchFlowNavigation?.goToProductDetailFromSearch(with: item)
        
    }
}


