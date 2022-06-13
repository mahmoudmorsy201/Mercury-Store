//
//  HomeViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import RxSwift
import RxCocoa

final class HomeViewModel {
    
    private weak var homeNavigation: HomeFlowNavigation!
    private let allProductsProvider: ProductsProvider
    private let draftOrderProvider: DraftOrderProvider
    private let disposeBag = DisposeBag()
    private let productsSubject = PublishSubject<[Product]>()
    private let isLoadingSubject = BehaviorRelay<Bool> (value: false)
    private let fetchedItemsFromCoreData = CoreDataModel.coreDataInstatnce.getItems(productState: productStates.cart).0
    
    var isLoading: Driver<Bool>
    let items = BehaviorSubject<[HomeTableViewSection]>(value: [
        .LogoSection(items: [
            .LogoTableViewItem
        ]),
        .CategoriesSection(items: [
            .CategoriesCell
        ]),
        .BannerSection(items: [
            .BannerTableViewItem
        ]),

        .BrandsSection(items: [
            .BrandsCell
        ])
    ])
    
    init(with homeNavigationFlow: HomeFlowNavigation, allProductsProvider: ProductsProvider = HomeScreenClient(),draftOrderProvider: DraftOrderProvider = HomeScreenClient()) {
        self.homeNavigation = homeNavigationFlow
        self.allProductsProvider = allProductsProvider
        self.draftOrderProvider = draftOrderProvider
        isLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)
    }
    
    func goToSearchViewController() {
        homeNavigation.goToSearchViewController()
    }

    
    func getAllProductsFromApi() {
        self.isLoadingSubject.accept(true)
        allProductsProvider.getAllProducts()
            .subscribe(onNext: {[weak self] result in
                guard let `self` = self else {fatalError()}
                //self.productsSubject.onNext(result.products)
                self.getDraftOrderById(result.products)
                self.isLoadingSubject.accept(false)
                
            }).disposed(by: disposeBag)
    }
    
    func getDraftOrderById(_ products: [Product]) {
        let user = getUserFromUserDefaults()
        if (user != nil) {
            self.isLoadingSubject.accept(true)
            self.draftOrderProvider.getDraftOrder(with: user!.cartId)
                .subscribe(onNext:  {[weak self] result in
                    guard let `self` = self else {fatalError()}
                    let variantIdsFromDraftOrderResponse = result.draftOrder.lineItems.map{ $0.variantID }
                    let filteredProducts = self.filter(items: products, contains: variantIdsFromDraftOrderResponse)
                    
                    if(self.fetchedItemsFromCoreData.isEmpty) {
                        for item in filteredProducts {
                            let newSaved = SavedProductItem(inventoryQuantity: item.variants[0].inventoryQuantity, variantId: item.variants[0].id, productID: Decimal(item.id), productTitle: item.title, productImage: item.image.src, productPrice: Double(item.variants[0].price)!, productQTY: 4, producrState: 1)
                          let _ = CoreDataModel.coreDataInstatnce.insertCartProduct(product: newSaved)
                        }
                        
                        
                        
                    }
                }).disposed(by: disposeBag)
        }

    }
        
    func filter(items: [Product], contains tags: [Int]) -> [Product] {
        var filteredProducts: [Product] = []
        for product in items {
            for tag in tags {
                if(product.variants[0].id == tag) {
                    filteredProducts.append(product)
                }
            }
        }
        return filteredProducts
   }
    
    private func getUserFromUserDefaults() -> User? {
        do {
            return try UserDefaults.standard.getObject(forKey: "user", castTo: User.self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

