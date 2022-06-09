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
        //TODO: Check login status
        /*
        let profileVC = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        profileVC.viewModel = ProfileViewModel(profileNavigationFlow: self)
        navigationController.pushViewController(profileVC, animated: true)
         */
        let guestViewModel = GuestViewModel(self)
        let guestVC = GuestProfileViewController(guestViewModel)
        navigationController.pushViewController(guestVC, animated: true)
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

extension ProfileCoordinator: GuestNavigationFlow {
    func goToRegistrationScreen() {
        let viewModel = RegisterViewModel(flow: self)
        let registrationVC = RegisterViewController(viewModel)
        self.navigationController.pushViewController(registrationVC, animated: true)
    }
    
    func goToLoginScreen() {
        let viewModel = LoginViewModel()
        let loginVC = LoginViewController(viewModel)
        self.navigationController.pushViewController(loginVC, animated: true)
    }
    
    
}
