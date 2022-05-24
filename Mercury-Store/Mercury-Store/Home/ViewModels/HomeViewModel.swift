//
//  HomeViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import RxSwift

struct HomeViewModel {
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
}


