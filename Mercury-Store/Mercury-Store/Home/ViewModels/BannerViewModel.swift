//
//  BannerViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

import RxSwift
import RxCocoa

protocol BannerViewModelType {
    var countForPageControll: Observable<Int> { get }
    var bannerObservable: Driver<[String]> {get}
}

final class BannerViewModel: BannerViewModelType {
    var bannerObservable: Driver<[String]>
    
    
    
    var countForPageControll: Observable<Int>
    
    private var bannersSubject: PublishSubject = PublishSubject<[String]>()
    
    init() {
        bannerObservable = Driver.just(BannerItemsConst.bannersArray)
        countForPageControll = Observable.just(BannerItemsConst.bannersArray.count)
    }
    
    
}

