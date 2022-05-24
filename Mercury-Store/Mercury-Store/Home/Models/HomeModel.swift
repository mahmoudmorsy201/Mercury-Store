//
//  HomeModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation

struct LogoModel {
    let imageLogo: String
}

struct CategoryModel {
    let items: [CategoryItem]
}

struct CategoryItem {
    let name: String
    let imageName: String
}

struct BrandModel {
    let brands: [Brand]
}

struct Brand {
    let name: String
    let imageName: String
}
