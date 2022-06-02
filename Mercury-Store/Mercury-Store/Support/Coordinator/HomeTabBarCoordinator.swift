//
//  HomeTabBarCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 02/06/2022.
//

import Foundation
import UIKit


final class HomeTabBarCoordinator : Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var mainTabBar: UITabBarController!
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        print("HomeTabBar Coordinator Init")
        initializeHomeTabBar()
    }
    
    deinit {
        print("HomeTabBar Coordinator deinit")
    }

    
    func initializeHomeTabBar(){
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator.init(navigationController: homeNavigationController)
        homeCoordinator.parentCoordinator = parentCoordinator
        
        let homeItem = UITabBarItem()
        homeItem.title = "Home"
        homeItem.image = UIImage.init(systemName: "homekit")
        homeNavigationController.tabBarItem = homeItem
        
        
        let categoriesNavigationController = UINavigationController()
        let categoryCoordinator = CategoryCoordinator.init(navigationController: categoriesNavigationController)
        categoryCoordinator.parentCoordinator = parentCoordinator
        
        
        let categoryItem = UITabBarItem()
        categoryItem.title = "Category"
        categoryItem.image = UIImage.init(systemName: "square.grid.2x2.fill")
        categoriesNavigationController.tabBarItem = categoryItem
        
        
        let cartNavigationController = UINavigationController()
        let cartCoordinator = ShoppingCartCoordinator.init(navigationController: cartNavigationController)
        categoryCoordinator.parentCoordinator = parentCoordinator
        
        
        let cartItem = UITabBarItem()
        cartItem.title = "Cart"
        cartItem.image = UIImage.init(systemName: "cart.fill")
        cartNavigationController.tabBarItem = cartItem
        
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator.init(navigationController: profileNavigationController)
        profileCoordinator.parentCoordinator = parentCoordinator
        
        let profileItem = UITabBarItem()
        profileItem.title = "Profile"
        profileItem.image = UIImage.init(systemName: "person.crop.circle.fill")
        profileNavigationController.tabBarItem = profileItem
        
        
        mainTabBar.viewControllers = [homeNavigationController, categoriesNavigationController, cartNavigationController,profileNavigationController]
        
        navigationController.pushViewController(mainTabBar, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)
        
        parentCoordinator?.children.append(homeCoordinator)
        parentCoordinator?.children.append(categoryCoordinator)
        parentCoordinator?.children.append(cartCoordinator)
        parentCoordinator?.children.append(profileCoordinator)
        
        homeCoordinator.start()
        categoryCoordinator.start()
        cartCoordinator.start()
        profileCoordinator.start()
    }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
        self.mainTabBar = UITabBarController()
    }
    
}
