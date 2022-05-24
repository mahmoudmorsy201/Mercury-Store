//
//  CategoryCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit


class CategoryCoordinator: CategoryBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: CategoryViewController(coordinator: self))
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .category(let categoryScreen):
            //TODO: Call handleCategoryFlow(categoryScreen, userData)
            break
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)

        }
    }
    
    //TODO: Make Category flow function like
    /*
     private func handleCategoryFlow(for screen: CategoryScreen, userData: [String : Any]? = nil) {
         switch screen {
         case .firstScreen:
             resetToRoot(animated: false)
         case .secondScreen:
             handleGoToSecondScreen()
         case .thirdScreen:
             handleGoToThirdScreen()
         }
     }
     
     private func handleGoToSecondScreen() {
         resetToRoot(animated: false)
         navigationRootViewController?.pushViewController(SeconedScreen(coordinator: self), animated: false)

     }
     
     private func handleGoToThirdScreen() {
         resetToRoot(animated: false)
         navigationRootViewController?.pushViewController(SecondScreen(coordinator: self), animated: false)
         navigationRootViewController?.pushViewController(ThirdScreen(coordinator: self), animated: false)
     }
     */
    
    
    
    
    @discardableResult
    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
    
    
    
}


