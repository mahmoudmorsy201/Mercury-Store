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
            .LogoTableViewItem(title: "LogoTest2")
        ]),
        .CategoriesSection(items: [
            .CategoriesCell(categoryItem: [
                CategoryItem(name: "Men", imageName: "tshirt.fill"),
                CategoryItem(name: "Women", imageName: "tshirt.fill"),
                CategoryItem(name: "Kid", imageName: "tshirt.fill"),
                CategoryItem(name: "Sale", imageName: "tshirt.fill")
            ])
        ]),
        .BannerSection(items: [
            .BannerTableViewItem(imageName: "of1")
        ]),

        .BrandsSection(items: [
            .BrandsCell(brands: [
                Brand(name: "Addidas", imageName: "of2"),
                Brand(name: "Addidas", imageName: "of2"),
                Brand(name: "Addidas", imageName: "of2"),
                Brand(name: "Addidas", imageName: "of2"),
                Brand(name: "Addidas", imageName: "of2"),
                Brand(name: "Addidas", imageName: "of2")
            ])
        ])
    ])
    
    let dataSource = HomeDataSource.dataSource()
}


