//
//  ProfileCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation
import UIKit


class ProfileCoordinator: ProfileBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: ProfileViewController(coordinator: self))
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        
    }
    
    
 
    
    
}
