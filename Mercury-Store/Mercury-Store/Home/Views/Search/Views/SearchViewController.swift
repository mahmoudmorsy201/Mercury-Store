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
    var viewModel: ProductViewModel!
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
    @IBOutlet weak var productListCollectionView: UICollectionView!
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductViewModel()
        // self.navigationController?.navigationBar.barTintColor = UIColor.black
        bindViews()
        
        // register product nib cell
        let productCell = UINib(nibName: Constants.productCell, bundle: nil)
        productListCollectionView.register(productCell, forCellWithReuseIdentifier: Constants.productCell)
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
}



