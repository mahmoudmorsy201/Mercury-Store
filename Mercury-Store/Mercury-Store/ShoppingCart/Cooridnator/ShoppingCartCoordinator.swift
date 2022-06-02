//
//  ShoppingCartCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 02/06/2022.
//

import UIKit

class ShoppingCartCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        print("ShoppingCartCoordinator Start")
        
        let cartVC = ShoppingCartViewController(nibName: String(describing: ShoppingCartViewController.self), bundle: nil)
        
        cartVC.viewModel = CartViewModel(shoppingCartNavigationFlow: self)
        navigationController.pushViewController(cartVC, animated: true)
    }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("Deinit ShoppingCartCoordinator")
    }
}

extension ShoppingCartCoordinator: ShoppingCartNavigationFlow {
    
}
