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
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(homeFlow: self)
        let homeVC = HomeViewController(with: viewModel)
        navigationController.pushViewController(homeVC, animated: true)
    }
}

extension HomeCoordinator: HomeFlowNavigation {
    func goToCategoriesTab(with itemName: String) {
        
    }
    
    func goToBrandDetails(with brandItem: SmartCollection) {
        
    }
    
    
}
