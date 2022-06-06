//
//  ProductDetailViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 03/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
protocol ProductsDetailViewModelType: AnyObject{
    var countForPageControll: Observable<Int> { get }
    var product : Product{get}
    var bannerObservable: Driver<[ProductImage]> {get}
    func sendImagesToCollection()
    func saveToFavourite()
    func saveToCart()
}

final class ProductsDetailViewModel: ProductsDetailViewModelType {
    private let productImagesSubject = PublishSubject<[ProductImage]>()
    var product: Product
    var countForPageControll: Observable<Int>
    var bannerObservable: Driver<[ProductImage]>
    weak var productDetailsNavigationFlow: ProductDetailsNavigationFlow?
    private let coreDataShared: CoreDataModel
    
    init(with productDetailsNavigationFlow: ProductDetailsNavigationFlow,product:Product, coreDataShared: CoreDataModel = CoreDataModel.coreDataInstatnce) {
        countForPageControll = Observable.just(product.images.count)
        bannerObservable = productImagesSubject.asDriver(onErrorJustReturn: [])
        self.product = product
        self.coreDataShared = coreDataShared
    }
    func sendImagesToCollection() {
        productImagesSubject.onNext(product.images)
    }
    func saveToFavourite() {
        coreDataShared.insert(item: SavedProductItem(productID: Decimal(product.id), productTitle: product.title, productImage: product.image.src , productPrice: Double(product.variants[0].price) ?? 0 , productQTY: 0 , producrState: productStates.favourite.rawValue))
    }
    func saveToCart() {
        coreDataShared.insert(item: SavedProductItem(productID: Decimal(product.id), productTitle: product.title, productImage: product.image.src , productPrice: Double(product.variants[0].price) ?? 0 , productQTY: 1 , producrState: productStates.cart.rawValue))
    }
}



