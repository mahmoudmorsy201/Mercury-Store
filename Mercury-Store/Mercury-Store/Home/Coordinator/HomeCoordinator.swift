//
//  HomeCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit

class HomeCoordinator : Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        print("HomeCoordinator Start")
        
        let homeVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        
        homeVC.viewModel = HomeViewModel(homeFlow: self)
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("Deinit home coordinator")
    }
    
}

extension HomeCoordinator: HomeFlow {
    func goToCategoriesTab(with itemName: String) {
        
    }
    
    func goToBrandDetails(with brandItem: SmartCollection) {
        
    }
    
    
}
