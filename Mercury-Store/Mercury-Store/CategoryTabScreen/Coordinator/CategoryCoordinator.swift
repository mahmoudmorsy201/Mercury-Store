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
    
    func start() {
        print("CategoryCoordinator Start")
        
        let categoryVC = CategoryViewController(nibName: String(describing: CategoryViewController.self), bundle: nil)
        
        //categoryVC.viewModel = CategoryViewModel(shoppingCartNavigationFlow: self)
        navigationController.pushViewController(categoryVC, animated: true)
    }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("Deinit CategoryCoordinator")
    }
    
    
}







//
//import UIKit
//
//
//class CategoryCoordinator: CategoryBaseCoordinator {
//
//    var parentCoordinator: MainBaseCoordinator?
//
//    lazy var rootViewController: UIViewController = UIViewController()
//
//    func start() -> UIViewController {
//        rootViewController = UINavigationController(rootViewController: CategoryViewController(coordinator: self))
//        return rootViewController
//    }
//
//    func moveTo(flow: AppFlow, userData: [String : Any]?) {
//        switch flow {
//        case .category(_):
//            navigationRootViewController?.popToRootViewController(animated: true)
//            handleCategoryFlow(for: .productsScreen)
//            break
//        default:
//            parentCoordinator?.moveTo(flow: flow, userData: userData)
//
//        }
//    }
//
//    //TODO: Make Category flow function like
//
//     private func handleCategoryFlow(for screen: CategoryScreen, userData: [String : Any]? = nil) {
//         switch screen {
//         case .initialScreen:
//             resetToRoot(animated: false)
//         case .productsScreen:
//             showCategoryProducts()
//         }
//     }
//
//     private func showCategoryProducts() {
//         resetToRoot(animated: false)
//         navigationRootViewController?.pushViewController(ProductResultViewController(coordinator: self), animated: false)
//
//     }
//    /*
//     private func handleGoToThirdScreen() {
//         resetToRoot(animated: false)
//         navigationRootViewController?.pushViewController(SecondScreen(coordinator: self), animated: false)
//         navigationRootViewController?.pushViewController(ThirdScreen(coordinator: self), animated: false)
//     }
//     */
//
//
//
//
//    @discardableResult
//    func resetToRoot(animated: Bool) -> Self {
//        navigationRootViewController?.popToRootViewController(animated: animated)
//        return self
//    }
//
//
//
//}
//
//
