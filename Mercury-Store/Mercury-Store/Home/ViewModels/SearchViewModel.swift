
//
//  SearchViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//
import Foundation
import RxSwift
import RxCocoa


protocol SearchViewModelType {
    
    var products : Driver<[Product]> { get }
    var isLoading : Driver<Bool> { get }
    var error : Driver<String?> { get }
    var filteredProducts :  Driver<[Product]> { get }
    func fetchData()
}

 class SearchViewModel <T> {
    // inputs
    private let searchSubject = PublishSubject<String>()
    var searchObserver: AnyObserver<String> {
        return searchSubject.asObserver()
    }
     
    // outputs
    private let loadingSubject = PublishSubject<Bool>()
    var isLoading: Driver<Bool> {
        return loadingSubject
            .asDriver(onErrorJustReturn: false)
    }

    private let errorSubject = PublishSubject<SearchError?>()
    var error: Driver<SearchError?> {
        return errorSubject
            .asDriver(onErrorJustReturn: SearchError.unkowned)
    }

    private let contentSubject = PublishSubject<[T]>()
    var content: Driver<[T]> {
        return contentSubject
            .asDriver(onErrorJustReturn: [])
    }
    func search(byTerm term: String) -> Observable<[T]> {
        fatalError("Override this function with your custom implementation")
    }
    enum SearchError: Error {
        case underlyingError(Error)
        case notFound
        case unkowned
    }

    private let bag = DisposeBag()
    init() {
        // 1
        searchSubject
            .asObservable()
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            // 2
            .flatMapLatest { [unowned self] term -> Observable<[T]> in
                // 3
                // every new try to search, the error signal will
                // emit nil to hide the error view
                self.errorSubject.onNext(nil)
                // 4
                // switch to loading mode
                self.loadingSubject.onNext(true)
                // 5
                return self.search(byTerm: term)
                    .catch { [unowned self] error -> Observable<[T]> in
                        self.errorSubject.onNext(SearchError.underlyingError(error))
                        return Observable.empty()
                }
            }
            .subscribe(onNext: { [unowned self] elements in
                // 6
                self.loadingSubject.onNext(false)
                // 7
                if elements.isEmpty {
                    self.errorSubject.onNext(SearchError.notFound)
                } else {
                    self.contentSubject.onNext(elements)
                }
            })
            // 8
            .disposed(by: bag)
    }
    
}
