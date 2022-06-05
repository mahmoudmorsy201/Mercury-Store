//
//  SearchViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController {
    
    var productList:[Product]!
    var searchBar = UISearchBar()
    var viewModel: ProductSearchViewModel!
    private let bag = DisposeBag()
    var errorView: UIView? {
        return nil
    }
    
    @IBOutlet weak var minimumPrice: UILabel!
    @IBOutlet weak var maximumPrice: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var productSearchbar: UISearchBar!
    @IBOutlet weak var sliderPrice: UISlider!
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var productListCollectionView: UICollectionView! {
        didSet {
            productListCollectionView.register(UINib(nibName: BrandProductsCollectionViewCell.reuseIdentifier(), bundle: nil), forCellWithReuseIdentifier: BrandProductsCollectionViewCell.reuseIdentifier())
        }
    }
    
    private let disposeBag = DisposeBag()
    
    init(with viewModel: ProductSearchViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        bindCollectionView()
    }
    
    private func bindViews() {
        productSearchbar
            .rx
            .text
            .orEmpty
            .bind(to: self.viewModel.searchObserver)
            .disposed(by: bag)
        viewModel.fetchData()
    }
    private func bindCollectionView() {
        viewModel.content.drive(productListCollectionView.rx.items(cellIdentifier: BrandProductsCollectionViewCell.reuseIdentifier(), cellType: BrandProductsCollectionViewCell.self)) { index, item , cell in
            cell.item = item
            
        }.disposed(by: disposeBag)
    }
}



