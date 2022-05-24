//
//  HomeViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit
import RxSwift
import RxDataSources

class HomeViewController: UIViewController, HomeBaseCoordinated {
    
    @IBOutlet weak private var homeActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak private var homeTableView: UITableView! {
        didSet {
            homeTableView.register(UINib(nibName: String(describing: LogoTableViewCell.self), bundle: nil), forCellReuseIdentifier: LogoTableViewCell.reuseIdentifier())
            homeTableView.register(UINib(nibName: BannerTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: BannerTableViewCell.reuseIdentifier())
            homeTableView.register(UINib(nibName: CategoriesTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: CategoriesTableViewCell.reuseIdentifier())
            homeTableView.register(UINib(nibName: BrandsTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: BrandsTableViewCell.reuseIdentifier())   
        }
    }
    
    var coordinator: HomeBaseCoordinator?
    
    init(coordinator: HomeBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Home"
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        coordinator?.moveTo(flow: .home(.searchScreen), userData: nil)
    }
    
    //MARK: Properties
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
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
            return 200
        case 2:
            return 160
        case 3:
            return 500
        default:
            return 150
        }
    }
}
