//
//  ProductDetailsViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 29/05/2022.
//

import UIKit

class ProductDetailsViewController: UIViewController{

    private var viewModel: ProductsDetailViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    init(with viewModel: ProductsDetailViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
