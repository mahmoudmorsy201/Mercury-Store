//
//  CategoryViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CategoryViewController: UIViewController,CategoryBaseCoordinated {
    private let disposeBag = DisposeBag()
    private let viewModel = CategoriesScreenViewModel()
    var coordinator: CategoryBaseCoordinator?
    //just to push
    let cateBackgroundIMG : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"categories_background")
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.5
        return iv
    }()
    
    @IBOutlet var categoriesCollectionView: UICollectionView!
    
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
        setupCollection()
    }
    private func setupCollection(){
        let nib = UINib(nibName: "CategoryItem", bundle: nil)
        categoriesCollectionView.register(nib, forCellWithReuseIdentifier: CategoryItem.identifier)
        viewModel.categories.drive(categoriesCollectionView.rx.items(cellIdentifier: CategoryItem.identifier, cellType: CategoryItem.self)){ index , element , cell in
            print(element)
            cell.config(item: element)
            cell.cellClickAction =  { (item) in
                self.coordinator?.moveTo(flow: .category(.productsScreen), userData: ["collection":item])
            }
        }.disposed(by: disposeBag)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.backgroundView = cateBackgroundIMG
    }
}
extension CategoryViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 200)
    }
}
