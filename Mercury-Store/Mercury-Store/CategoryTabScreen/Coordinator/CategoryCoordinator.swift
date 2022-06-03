//
//  CategoryCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit

class CategoryCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    
        let categoryVC = CategoryViewController(nibName: String(describing: CategoryViewController.self), bundle: nil)
        
        //categoryVC.viewModel = CategoryViewModel(shoppingCartNavigationFlow: self)
        navigationController.pushViewController(categoryVC, animated: true)
    }
    
    
    
}
