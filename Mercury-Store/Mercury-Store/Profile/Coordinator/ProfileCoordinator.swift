//
//  ProfileCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation
import UIKit


class ProfileCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ProfileViewModel(profileNavigationFlow: self)
        let profileVC = ProfileViewController(with: viewModel)
        navigationController.pushViewController(profileVC, animated: true)
    }
}

extension ProfileCoordinator: ProfileNavigationFlow {
    
    func goToMyOrdersScreen() {
        let myOrdersVC = myOrdersTableViewController(nibName: String(describing: myOrdersTableViewController.self), bundle: nil)
        
        self.navigationController.pushViewController(myOrdersVC, animated: true)
    }
    
    func goToMyWishListScreen() {
        let myWishListVC = WishListViewController(nibName: String(describing: WishListViewController.self), bundle: nil)
        
        self.navigationController.pushViewController(myWishListVC, animated: true)
    }
    
    func goToMyAddressesScreen() {
        let myAddressesVC = AddressViewController(nibName: String(describing: AddressViewController.self), bundle: nil)
        
        self.navigationController.pushViewController(myAddressesVC, animated: true)
        
    }
    
    func goToAboutUsScreen() {
        let aboutUsVC = AboutUsViewController(nibName: String(describing: AboutUsViewController.self), bundle: nil)
        
        self.navigationController.pushViewController(aboutUsVC, animated: true)
    }
    
    func goToMainTab() {
        UserDefaults.standard.removeObject(forKey: "user")
        let appC = self.parentCoordinator?.parentCoordinator as! ApplicationCoordinator
        appC.goToHomeTabbar()
        appC.childDidFinish(self)
    }
    

    
}
