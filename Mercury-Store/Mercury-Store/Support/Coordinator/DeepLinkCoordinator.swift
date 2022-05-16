//
//  DeepLinkCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation


class DeepLinkCoordinator: DeepLinkBaseCoordinator {
    
    func handleDeeplink(deepLink: String) {
        print("")
    }
    
    var parentCoordinator: MainBaseCoordinator?
    
    init(mainBaseCoordinator: MainBaseCoordinator) {
        self.parentCoordinator = mainBaseCoordinator
    }
}
