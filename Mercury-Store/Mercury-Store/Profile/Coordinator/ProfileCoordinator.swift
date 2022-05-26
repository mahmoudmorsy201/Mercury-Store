//
//  ProfileCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation
import UIKit


class ProfileCoordinator: ProfileBaseCoordinator{
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: ProfileViewController(coordinator: self))
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .profile(let profileScreen):
             handleProfileFlow(for: profileScreen, userData: userData)
       
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
        
    }
    func handleProfileFlow(for screen : ProfileScreen,userData: [String: Any]?){
        
        switch screen{
        case .intialScreen:
            navigationRootViewController?.popToRootViewController(animated: true)
        case .guestScreen:
                   goToGuestScreenWith (title: "guest")
        case .aboutScreen:
                   goToAboutScreenWith (title: "about")
        case .loginScreen:
                   goToLoginScreenWith (title: "login")
        case .logoutScreen:
                  goTologoutScreenWith ()
        case .registerScreen:
                 goToRegisterScreenWith (title: "register")
        case .myAddressesScreen:
                goTomyAddressesScreenWith (title: "addresses")
        case .myOrdersScreen:
               goTomyOrdersScreenWith (title: "orders")
        case .myWishlistScreen:
               goTomyWishlistScreenWith (title: "myWishlist")
        case .shoppingCartScreen:
               goToshoppingCartScreenWith (title: "shoppingCart")
       
                    }
        
        
    }
   
    
    func goToGuestScreenWith(title: String) {
        navigationRootViewController?.pushViewController(GuestProfileViewController(coordinator: self), animated: false)
    }
    func goToAboutScreenWith (title: String) {
        resetToRoot()
      navigationRootViewController?.pushViewController(AboutUsViewController(coordinator: self), animated: false)
    }
    
    func goToLoginScreenWith(title: String){
         
        navigationRootViewController?.pushViewController(LoginViewController(coordinator: self), animated: false)
        
    }
    
    func goToRegisterScreenWith(title: String){
        
        navigationRootViewController?.pushViewController(RegisterViewController(coordinator: self), animated: false)
        
    }
  
    func  goTologoutScreenWith (){
       // resetToRoot(animated: true)
        parentCoordinator?.moveTo(flow: .home(.intialScreen), userData: nil)

        
    }
    func goTomyAddressesScreenWith(title:String){
        resetToRoot()
        navigationRootViewController?.pushViewController(AddressViewController(coordinator: self), animated: false)
        
    }
    func goTomyOrdersScreenWith(title:String){
        resetToRoot()
        navigationRootViewController?.pushViewController(myOrdersTableViewController(coordinator: self), animated: false)
    }
    func  goTomyWishlistScreenWith(title:String){
        resetToRoot()
        navigationRootViewController?.pushViewController(WishListViewController(coordinator: self), animated: false)
    }
    
    func  goToshoppingCartScreenWith(title:String){
         resetToRoot()
      //  parentCoordinator?.moveTo(flow: .shoppingCart(<#T##ShoppingCartScreen#>), userData: nil)
         
    }
    @discardableResult
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
    
    
    
}


