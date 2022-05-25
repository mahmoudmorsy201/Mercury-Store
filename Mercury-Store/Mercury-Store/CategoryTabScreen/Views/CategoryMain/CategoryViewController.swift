//
//  CategoryViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit

class CategoryViewController: UIViewController,CategoryBaseCoordinated {
    var coordinator: CategoryBaseCoordinator?
    //just to push
    let cateBackgroundIMG : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"categories_background")
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.5
        return iv
    }()
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    init(coordinator: CategoryBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Categories"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CategoryItem", bundle: nil)
        categoriesCollectionView.register(nib, forCellWithReuseIdentifier: CategoryItem.identifier)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.backgroundView = cateBackgroundIMG
    }
    
}

