//
//  FilterViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 26/05/2022.
//

import UIKit

class FilterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        
        title = "Filter Products"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
