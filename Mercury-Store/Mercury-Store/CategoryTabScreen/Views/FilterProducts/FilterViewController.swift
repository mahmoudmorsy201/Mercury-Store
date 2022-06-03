//
//  FilterViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 26/05/2022.
//

import UIKit

class FilterViewController: UIViewController {
//    var coordinator: CategoryBaseCoordinator?
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    init(/*_coordinator: CategoryBaseCoordinator*/) {
        super.init(nibName: nil, bundle: nil)
        //self.coordinator = _coordinator
        title = "Filter Products"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
