//
//  SearchViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import ProgressHUD

class SearchViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var minimumPrice: UILabel!
    @IBOutlet weak var maximumPrice: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var productSearchbar: UISearchBar!
    @IBOutlet weak var sliderPrice: UISlider!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var switchSort: UISwitch!
    
    @IBOutlet weak var productListCollectionView: UICollectionView! {
        didSet {
            productListCollectionView.register(UINib(nibName: BrandProductsCollectionViewCell.reuseIdentifier(), bundle: nil), forCellWithReuseIdentifier: BrandProductsCollectionViewCell.reuseIdentifier())
        }
    }

    var viewModel: ProductSearchViewModel?
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
        bindToSearchValue()
        bindSelectedItem()
        bindFilterBtn()
        bindSlider()
        bindPrice()
        bindActivity()
        viewModel?.fetchData()
        bindSortBtn()
        bind()
    }
    
    func bind() {
        guard let viewModel = viewModel else {
            fatalError("Couldn't unwrap viewModel")
        }
        
        productListCollectionView.delegate = nil
        productListCollectionView.dataSource = nil
        productListCollectionView.rx.setDelegate(self).disposed(by: bag)
        
        let output = viewModel.bind()
        
        output.filteredItems.bind(to: productListCollectionView.rx.items(dataSource: dataSource()))
            .disposed(by: bag)
        
    }
    private func hideSlider() {
        maximumPrice.isHidden = true
        minimumPrice.isHidden = true
        priceSlider.isHidden = true
    }
    
    func bindToSearchValue() {
        productSearchbar.rx.text
            .bind(to: viewModel!.searchByName)
            .disposed(by: bag)
    }
    
    private func bindSlider(){
        sliderPrice.rx.value
            .map{Int($0)}
            .bind(to: viewModel!.value)
            .disposed(by: bag)
    }
    private func bindSortBtn() {
        switchSort.rx.value
            .bind(to: viewModel!.sortAlphabetically)
            .disposed(by: bag)
    }
    private func bindPrice(){
        viewModel?.value.asDriver()
            .map { "EGP \($0) " }
            .drive(maximumPrice.rx.text)
            .disposed(by: bag)
    }
    
    private func bindFilterBtn(){
        filterBtn.rx.tap.bind {
            self.filterBtnIsPressed()
            
        }.disposed(by: bag)
    }

    private func bindActivity() {
        viewModel?.isLoadingData.drive(ProgressHUD.rx.isAnimating)
        .disposed(by: bag)
    }
    
    private func bindSelectedItem() {
        productListCollectionView.rx.modelSelected(Product.self).subscribe{ [weak self] item in

            self?.viewModel?.goToProductDetailFromSearch(with: item)
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

extension SearchViewController {
    
    private func dataSource() -> RxCollectionViewSectionedReloadDataSource<SearchSection> {
        .init {datasource, collectionView, indexPath, row in
            let cell: BrandProductsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandProductsCollectionViewCell.reuseIdentifier(), for: indexPath) as! BrandProductsCollectionViewCell
        
            cell.item = row
           
            return cell
        }
    }
}



