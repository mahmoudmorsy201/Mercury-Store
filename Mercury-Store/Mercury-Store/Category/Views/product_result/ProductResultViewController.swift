//
//  ProductResultViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 23/05/2022.
//

import UIKit

class ProductResultViewController: UIViewController , CategoryBaseCoordinated{
    var coordinator: CategoryBaseCoordinator?
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    init(coordinator: CategoryBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Categoryx Products"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
