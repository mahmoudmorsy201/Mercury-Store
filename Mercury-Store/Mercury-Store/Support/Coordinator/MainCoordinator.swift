//
//  MainCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit


enum AppFlow {
    case home(HomeScreen)
    case category(CategoryScreen)
    case shoppingCart(ShoppingCartScreen)
    case profile(ProfileScreen)
}

enum HomeScreen {
    case intialScreen
    case searchScreen
    case favouriteScreen
    case productDetailScreen
}

enum CategoryScreen {
    case initialScreen
    case productsScreen
    case filterProductScreen
}

enum ShoppingCartScreen {
    
}

enum ProfileScreen {
    
}

class MainCoordinator: MainBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    
    lazy var rootViewController: UIViewController = UITabBarController()
    lazy var homeCoordinator: HomeBaseCoordinator = HomeCoordinator()
    lazy var categoryCoordinator: CategoryBaseCoordinator = CategoryCoordinator()
    lazy var shoppingCartCoordinator: ShoppingCartBaseCoordinator = ShoppingCartCoordinator()
    lazy var profileCoordinator: ProfileBaseCoordinator = ProfileCoordinator()
    lazy var deepLinkCoordinator: DeepLinkBaseCoordinator = DeepLinkCoordinator(mainBaseCoordinator: self)
    
    func start() -> UIViewController {
        let homeViewController = homeCoordinator.start()
        homeCoordinator.parentCoordinator = self
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit"), tag: 0)
        
        let categoryViewController = categoryCoordinator.start()
        categoryCoordinator.parentCoordinator = self
        categoryViewController.tabBarItem = UITabBarItem(title: "Category", image: UIImage(systemName: "square.grid.2x2.fill"), tag: 1)
        
        let shoppingCartViewController = shoppingCartCoordinator.start()
        shoppingCartCoordinator.parentCoordinator = self
        shoppingCartViewController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart.fill"), tag: 2)
        
        let profileViewController = profileCoordinator.start()
        profileCoordinator.parentCoordinator = self
        profileViewController.tabBarItem = UITabBarItem(title: "Me", image: UIImage(systemName: "person.crop.circle.fill"), tag: 3)
        
        
        
        
        (rootViewController as? UITabBarController)?.viewControllers = [homeViewController, categoryViewController, shoppingCartViewController, profileViewController]
        
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .home:
            goToHomeFlow(flow)
        case .category:
            goToCategoryFlow(flow)
        case .shoppingCart:
            goToShoppingCartFlow(flow)
        case .profile:
            break
        }
    }
    
    
    private func goToHomeFlow(_ flow: AppFlow) {
        homeCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
    }
    
    
    private func goToCategoryFlow(_ flow: AppFlow) {
        categoryCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }
    
    private func goToShoppingCartFlow(_ flow: AppFlow) {
        shoppingCartCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
     
    
    func handleDeepLink(text: String) {
        deepLinkCoordinator.handleDeeplink(deepLink: text)
    }
    

    
    
    func resetToRoot() -> Self {
        homeCoordinator.resetToRoot(animated: false)
        moveTo(flow: .home(.intialScreen), userData: nil)
        return self
    }
    
    
    
    
}


