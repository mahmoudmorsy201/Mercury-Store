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
  //TODO: get the data from coordinator
    var countForPageControll: Observable<Int> { get }
    var product : Product{get}
    var bannerObservable: Driver<[ProductImage]> {get}
}

final class ProductsDetailViewModel: ProductsDetailViewModelType {
    var product: Product
    var countForPageControll: Observable<Int>
    var bannerObservable: Driver<[ProductImage]>
    weak var productDetailsNavigationFlow: ProductDetailsNavigationFlow?
    
    init(with productDetailsNavigationFlow: ProductDetailsNavigationFlow,product:Product) {
        self.product = product
        countForPageControll = Observable.just(product.images.count)
        bannerObservable = Driver.just(product.images)
    }
}



