//
//  MainBaseCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import Foundation

protocol MainBaseCoordinator: Coordinator {
    var homeCoordinator: HomeBaseCoordinator { get }
    var categoryCoordinator: CategoryBaseCoordinator { get }
    var shoppingCartCoordinator: ShoppingCartBaseCoordinator { get }
    var profileCoordinator: ProfileBaseCoordinator { get }
    var deepLinkCoordinator: DeepLinkBaseCoordinator { get }
    func handleDeepLink(text: String)
}

protocol HomeBaseCoordinated {
    var coordinator: HomeBaseCoordinator? { get }
}

protocol CategoryBaseCoordinated {
    var coordinator: CategoryBaseCoordinator? { get }
}

protocol ShoppingCartCoordinated {
    var coordinator: ShoppingCartBaseCoordinator? { get }
}

protocol ProfileCoordinated {
    var coordinator: ProfileBaseCoordinator? { get }
}
