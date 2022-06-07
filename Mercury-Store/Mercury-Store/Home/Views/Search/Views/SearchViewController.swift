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
    var viewModel: ProductSearchViewModel!
    private var bag = DisposeBag()
    var filterIsPressed = true
    var errorView: UIView? {
        return nil
    }
    
    init(with viewModel: ProductSearchViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSlider()
        bindViews()
        bindCollectionView()
        bindSelectedItem()
        bindFilterBtn()
        bindSlider()
        bindPrice()
        

    }
    private func hideSlider() {
        maximumPrice.isHidden = true
        minimumPrice.isHidden = true
        priceSlider.isHidden = true
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
    
    private func bindSlider(){
        sliderPrice.rx.value
            .map { Int($0)}
            .bind(to: viewModel.value)
                  .disposed(by: bag)
    }
    private func bindPrice(){
        // If you want to listen and bind to a label
               viewModel.value.asDriver()
                   .map { "EGP \($0) " }
                   .drive(maximumPrice.rx.text)
                   .disposed(by: bag)
    }
    private func bindFilterBtn(){
        filterBtn.rx.tap.bind {
            self.filterBtnIsPressed()
        }.disposed(by: bag)
    }
    private func bindCollectionView() {
        viewModel.content.drive(productListCollectionView.rx.items(cellIdentifier: BrandProductsCollectionViewCell.reuseIdentifier(), cellType: BrandProductsCollectionViewCell.self)) { index, item , cell in
            cell.item = item
        }.disposed(by: bag)
    }
    
    private func bindSelectedItem() {
        productListCollectionView.rx.modelSelected(Product.self).subscribe{ [weak self] item in
            
            self?.viewModel.goToProductDetailFromSearch(with: item)
        }.disposed(by: bag)

        
    }
    private func filterBtnIsPressed(){
        if filterIsPressed{
            filterIsPressed = false
            minimumPrice.isHidden = false
            maximumPrice.isHidden = false
            priceSlider.isHidden = false
        }else{
            minimumPrice.isHidden = true
            maximumPrice.isHidden = true
            filterIsPressed = true
            priceSlider.isHidden = true
        }
    }
}



