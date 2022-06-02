//
//  CategoryViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //just to push
    let cateBackgroundIMG : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"categories_background")
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.5
        return iv
    }()
    
    @IBOutlet var categoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CategoryItem", bundle: nil)
        categoriesCollectionView.register(nib, forCellWithReuseIdentifier: CategoryItem.identifier)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.backgroundView = cateBackgroundIMG
    }
    
}

