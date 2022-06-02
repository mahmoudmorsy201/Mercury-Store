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
    
    func start() {
        print("Profile Start")
        
        let profileVC = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        profileVC.viewModel = ProfileViewModel(profileNavigationFlow: self)
        navigationController.pushViewController(profileVC, animated: true)
    }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("Deinit profile coordinator")
    }
}

extension ProfileCoordinator: ProfileNavigationFlow {
    
    func goToMyOrdersScreen() {
        let myOrdersVC = MyOrderDetailsController(nibName: String(describing: MyOrderDetailsController.self), bundle: nil)
        
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
        self.navigationController.tabBarController?.selectedIndex = 0
    }
    
}
