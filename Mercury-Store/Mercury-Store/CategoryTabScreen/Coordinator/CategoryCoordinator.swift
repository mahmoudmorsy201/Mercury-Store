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
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    
        //let categoryVC = CategoryViewController(nibName: String(describing: CategoryViewController.self), bundle: nil)
        
        //categoryVC.viewModel = CategoryViewModel(shoppingCartNavigationFlow: self)
        //navigationController.pushViewController(categoryVC, animated: true)
    }
    
    func moveTo(/*flow: AppFlow,*/ userData: [String : Any]?) {
//        switch flow {
//        case .category(let screen):
//            navigationRootViewController?.popToRootViewController(animated: true)
//            handleCategoryFlow(for: screen, userData: userData)
//            break
//        default:
//            parentCoordinator?.moveTo(flow: flow, userData: userData)
//
//        }
    }
    
    //TODO: Make Category flow function like
    
     private func handleCategoryFlow(/*for screen: CategoryScreen, */ userData: [String : Any]? = nil) {
//         switch screen {
//         case .initialScreen:
//             resetToRoot(animated: false)
//         case .productsScreen:
//             showCategoryProducts(userData: userData ?? nil)
//         case .filterProductScreen:
//             showFilterProducts()
//         case .productDetailScreen:
//             productDetails(userData: userData ?? nil)
//         }
     }
     
     private func showCategoryProducts(userData:[String:Any]?) {
         resetToRoot(animated: false)
         //navigationRootViewController?.pushViewController(ProductResultViewController(coordinator: self, collection: userData!) , animated: false)

     }
    private func showFilterProducts() {
        resetToRoot(animated: false)
        //navigationRootViewController?.pushViewController(FilterViewController(_coordinator: self), animated: false)

    }
    private func productDetails(userData:[String:Any]?){
       // navigationRootViewController?.pushViewController(ProductDetailsViewController(coordinator: self, product: userData! ), animated: false)
    }
 
    @discardableResult
    func resetToRoot(animated: Bool) -> Self {
       // navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
    
    
    
}
