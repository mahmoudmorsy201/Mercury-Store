//
//  HomeViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import RxSwift
protocol HomeFlow: AnyObject {
    func goToCategoriesTab(with itemName: String)
    func goToBrandDetails(with brandItem: SmartCollection)
}

struct HomeViewModel {
    
    weak var homeFlow: HomeFlow!
    
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
    
    init(homeFlow: HomeFlow) {
        self.homeFlow = homeFlow
    }
    
    func goToCategoriesTab(with itemName: String) {
        homeFlow.goToCategoriesTab(with: itemName)
    }
    func goToBrandDetails(with brandItem: SmartCollection) {
        homeFlow.goToBrandDetails(with: brandItem)
    }
    
    let dataSource = HomeDataSource.dataSource()
}


