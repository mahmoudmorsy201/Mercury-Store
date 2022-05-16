//
//  DeepLinkBaseCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation


protocol DeepLinkBaseCoordinator: FlowCoordinator {
    func handleDeeplink(deepLink: String)
}
