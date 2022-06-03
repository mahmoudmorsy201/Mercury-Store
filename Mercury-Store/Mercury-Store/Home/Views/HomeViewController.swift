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
    
    //MARK: Properties
    private let disposeBag = DisposeBag()
    private var viewModel: HomeViewModel!
    
    init(with viewModel: HomeViewModel) {
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycle
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
            .bind(to: homeTableView.rx.items(dataSource: viewModel.dataSource))
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
