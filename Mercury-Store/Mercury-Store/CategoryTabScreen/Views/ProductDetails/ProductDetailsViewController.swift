//
//  ProductDetailsViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 29/05/2022.
//

import UIKit

class ProductDetailsViewController: UIViewController{
    //var coordinator: CategoryBaseCoordinator?
    var product :Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    init(/*coordinator: CategoryBaseCoordinator */product: [String:Any] ) {
        super.init(nibName: nil, bundle: nil)
        //self.coordinator = coordinator
        self.product = product["product"] as! Product
        title = self.product?.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
