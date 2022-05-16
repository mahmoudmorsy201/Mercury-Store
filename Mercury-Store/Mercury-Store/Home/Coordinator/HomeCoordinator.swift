//
//  HomeCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit

class HomeCoordinator: HomeBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: HomeViewController(coordinator: self))
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .home(let homeScreen):
            handleHomeFlow(for: homeScreen, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }
    
    private func handleHomeFlow(for screen: HomeScreen, userData: [String: Any]?) {
        switch screen {
        case .intialScreen:
            navigationRootViewController?.popToRootViewController(animated: true)
        case .searchScreen:
            goToSearchScreenWith(title: "Search")
        case .favouriteScreen:
            //TODO: call goToFavouriteScreen()
            break
        case .productDetailScreen:
            //TODO: call goToProductDetailScreenWtih(product: Product)
            break
        }
        
    }
    
    func goToSearchScreenWith(title: String) {
        resetToRoot()
        navigationRootViewController?.pushViewController(SearchViewController(coordinator: self), animated: false)
    }
    
    func goToFavouriteScreen() {
        //TODO: navigate to favourite screen and push the view controller to the stack
    }
    
    //TODO: Create function goToProductDetailScreenWtih(product: Product) then navigate to it 
    
    
    @discardableResult
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
    
    
    
}
