//
//  ShoppingCartViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit

class ShoppingCartViewController: UIViewController, ShoppingCartCoordinated {
    var coordinator: ShoppingCartBaseCoordinator?
    
    
    init(coordinator: ShoppingCartBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Cart"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
    }


}
