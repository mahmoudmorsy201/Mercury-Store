//
//  ApplicationCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 02/06/2022.
//

import Foundation
import UIKit

class ApplicationCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("AppCoordinator Start")
       goToHomeTabbar()
    }
    
    func goToLaunchScreen(){
        
    }
    
    func goToHomeTabbar(){
        let coordinator = HomeTabBarCoordinator.init(navigationController: navigationController)
        children.removeAll()
        
        coordinator.parentCoordinator = self
        
        coordinator.start()
    }
    
    deinit {
        print("AppCoordinator deinit")
    }
    
    
}
