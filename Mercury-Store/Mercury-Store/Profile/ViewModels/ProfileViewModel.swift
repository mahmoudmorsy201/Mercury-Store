//
//  ProfileViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import RxSwift
import RxCocoa

class ProfileViewModel {
    
    
    private var _sectionModels: BehaviorSubject<[ProfileSectionModel]> = BehaviorSubject(value: [])
    
    var sectionModels: SharedSequence<DriverSharingStrategy, [ProfileSectionModel]> {
        return _sectionModels.asDriver(onErrorJustReturn: [])
    }
    func configureSectionModel() {
        let sections: [ ProfileSectionModel] = [
            .myAccountSection(title: "My Account", items: [
                .myAccountItem(image: UIImage(systemName: "bag")! , title: "My Orders"),
                .myAccountItem(image:  UIImage(systemName: "heart")!, title: "My WishList"),
                .myAccountItem(image:  UIImage(systemName: "homekit")!, title: "My Addresses")
            ]),
            .aboutSection(title: "About", items: [
                .aboutItem(image:  UIImage(systemName: "info.circle")!, title: "About Us")
                
            ])
        ]
        
        _sectionModels.onNext(sections)
    }


}
