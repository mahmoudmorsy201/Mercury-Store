//
//  ProductResultViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 23/05/2022.
//

import UIKit

class ProductResultViewController: UIViewController {
    
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: ProductCell.identifier)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
    }
    
}
