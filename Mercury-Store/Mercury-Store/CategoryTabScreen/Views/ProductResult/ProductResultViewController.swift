//
//  ProductResultViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 23/05/2022.
//

import UIKit
import RxSwift
import ProgressHUD

class ProductResultViewController: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    private var viewModel:FilteredProductsViewModelType?
    
    init(with viewModel: FilteredProductsViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindActivity()
        
    }
    
    private func setupCollectionView(){
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: ProductCell.identifier)
        
        viewModel?.products.drive(productCollectionView.rx.items(cellIdentifier: ProductCell.identifier, cellType: ProductCell.self)){[weak self] index , element , cell in
            guard let `self` = self else {fatalError()}
            cell.cellClickAction =  { (item) in
                self.viewModel?.goToProductDetail(with: item)
            }
            cell.configure(item: element)
        }.disposed(by: disposeBag)
        productCollectionView.delegate = self
    }
    
    private func bindActivity() {
        viewModel?.isLoading.drive(ProgressHUD.rx.isAnimating)
        .disposed(by: disposeBag)
    }

    @IBAction func filterAction(_ sender: Any) {
        self.viewModel?.goToFilteredProductScreen()
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
