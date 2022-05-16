//
//  CategoryViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit

class CategoryViewController: UIViewController,CategoryBaseCoordinated {
    var coordinator: CategoryBaseCoordinator?
    
    init(coordinator: CategoryBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Category"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }



}

