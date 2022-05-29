//
//  ProductResultViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 23/05/2022.
//

import UIKit
import RxSwift
class ProductResultViewController: UIViewController , CategoryBaseCoordinated{
    var coordinator: CategoryBaseCoordinator?
    private let disposeBag = DisposeBag()
    private var CategoryID:Int?
    var viewModel:CategoryProductsScreenViewModelType?
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    func setupCollectionView(){
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: ProductCell.identifier)
//        viewModel.products.drive(productCollectionView.rx.items(cellIdentifier: ProductCell.identifier, cellType: ProductCell.self)){index , element , cell in
//            cell.configure(item: element)
//        }
        productCollectionView.delegate = self
    }
    init(coordinator: CategoryBaseCoordinator ,collection: [String:Any]) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        let category:SmartCollectionElement = collection["collection"] as! SmartCollectionElement
        title = "\(category.title) Products"
        self.viewModel = CategoryProductsScreenViewModel(categoryID: category.id)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        coordinator?.moveTo(flow: .category(.filterProductScreen), userData: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension ProductResultViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 200)
    }
    
    
}
