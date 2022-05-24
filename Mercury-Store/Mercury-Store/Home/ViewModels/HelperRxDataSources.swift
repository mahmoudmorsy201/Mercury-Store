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

struct HomeDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<HomeTableViewSection> {
        return  .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            switch dataSource[indexPath] {
            case .LogoTableViewItem:
                
                guard let logoCell = tableView.dequeueReusableCell(withIdentifier: LogoTableViewCell.reuseIdentifier(), for: indexPath) as? LogoTableViewCell else {
                    fatalError("Couldn't dequeue logo cell")
                }
                
                return logoCell
            case .CategoriesCell:
                guard let categoriesCell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.reuseIdentifier(), for: indexPath) as? CategoriesTableViewCell else {
                    fatalError("Couldn't dequeue categories cell")
                }
                
                categoriesCell.viewModel = CategoriesViewModel()
                
                return categoriesCell
            case .BannerTableViewItem:
                guard let bannerCell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.reuseIdentifier(), for: indexPath) as? BannerTableViewCell else {
                    fatalError("Couldn't dequeue banner cell")
                }
                
                bannerCell.viewModel = BannerViewModel()
                return bannerCell
            case .BrandsCell:
                guard let brandsCell = tableView.dequeueReusableCell(withIdentifier: BrandsTableViewCell.reuseIdentifier(), for: indexPath) as? BrandsTableViewCell else {
                    fatalError("Couldn't dequeue brands cell")
                }
                let brandProvider: BrandsProvider = HomeScreenAPI()
                brandsCell.viewModel = BrandsViewModel(brandsProvider: brandProvider)
                return brandsCell
        
            }
        },  titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].header
        })
    }
}
