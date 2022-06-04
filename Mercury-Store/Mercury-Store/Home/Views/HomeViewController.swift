//
//  HomeViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit
import RxSwift
import RxDataSources

class HomeViewController: UIViewController {
    
    @IBOutlet weak private var homeActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak private var homeTableView: UITableView! {
        didSet {
            homeTableView.register(UINib(nibName: String(describing: LogoTableViewCell.self), bundle: nil), forCellReuseIdentifier: LogoTableViewCell.reuseIdentifier())
            homeTableView.register(UINib(nibName: BannerTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: BannerTableViewCell.reuseIdentifier())
            homeTableView.register(UINib(nibName: CategoriesTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: CategoriesTableViewCell.reuseIdentifier())
            homeTableView.register(UINib(nibName: BrandsTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: BrandsTableViewCell.reuseIdentifier())   
        }
    }
    
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private var viewModel: HomeViewModel!
    private var brandViewModel: BrandsViewModel!
    private var categoryViewModel: CategoriesViewModel!
    
    init(with viewModel: HomeViewModel, and brandViewModel: BrandsViewModel, categoryViewModel: CategoriesViewModel) {
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
        self.viewModel = viewModel
        self.brandViewModel = brandViewModel
        self.categoryViewModel = categoryViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        createSearchBarButton()
        bindTableView()
        

    }
    
    private func createSearchBarButton() {
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBtnTapped))
        self.navigationItem.rightBarButtonItem = search
    }
    
    @objc func searchBtnTapped() {
        
    }
    

}

extension HomeViewController {
    private func bindTableView() {
        viewModel.items
            .bind(to: homeTableView.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 110
        case 1:
            return 130
        case 2:
            return 200
        case 3:
            return 500
        default:
            return 150
        }
    }
}

extension HomeViewController {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    private func dataSource() -> DataSource<HomeTableViewSection> {
        return  .init(configureCell: {[weak self] dataSource, tableView, indexPath, item -> UITableViewCell in
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
                
                categoriesCell.viewModel = self?.categoryViewModel
                
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
                brandsCell.viewModel = self?.brandViewModel
                return brandsCell
        
            }
        },  titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].header
        })
    }
}
