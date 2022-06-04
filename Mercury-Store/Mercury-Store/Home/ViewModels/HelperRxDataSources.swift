//
//  HelperRxDataSources.swift
//  Mercury-Store
//
//  Created by mac hub on 21/05/2022.
//

import RxDataSources

enum HomeTableViewItem {
    case LogoTableViewItem
    case CategoriesCell
    case BannerTableViewItem
    case BrandsCell
}

enum HomeTableViewSection {
    case LogoSection(items: [HomeTableViewItem])
    case BannerSection(items: [HomeTableViewItem])
    case CategoriesSection(items: [HomeTableViewItem])
    case BrandsSection(items: [HomeTableViewItem])
}

extension HomeTableViewSection: SectionModelType {

    typealias Item = HomeTableViewItem
    
    var header: String {
        switch self {
        case .LogoSection:
            return ""
        case .CategoriesSection:
            return ""
        case .BannerSection:
            return ""
        case .BrandsSection:
            return "Brands: "
        }
    }
    
    var items: [HomeTableViewItem] {
        switch self {
        case .LogoSection(items: let items):
            return items
        case .CategoriesSection(items: let items):
            return items
        case .BannerSection(items: let items):
            return items
        case .BrandsSection(items: let items):
            return items
        }
    }
    
    init(original: HomeTableViewSection, items: [Self.Item]) {
        self = original
    }
}
