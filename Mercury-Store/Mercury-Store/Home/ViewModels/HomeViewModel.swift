//
//  HomeViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import RxSwift



struct HomeViewModel {
    
    private weak var homeFlow: HomeFlowNavigation!
    
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
    let dataSource = HomeDataSource.dataSource()
    
    init(homeFlow: HomeFlowNavigation) {
        self.homeFlow = homeFlow
    }
}

extension HomeViewModel {
    func goToCategoriesTab(with itemName: String) {
        homeFlow.goToCategoriesTab(with: itemName)
    }
    func goToBrandDetails(with brandItem: SmartCollection) {
        homeFlow.goToBrandDetails(with: brandItem)
    }
}

