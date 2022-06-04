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
import ProgressHUD

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var mainCategoryItems: UITableView!
    
    
    @IBOutlet var categoriesCollectionView: UICollectionView!
    
    let cateBackgroundIMG : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"categories_background")
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.5
        return iv
    }()
    
    private let disposeBag = DisposeBag()
    private var viewModel: CategoriesScreenViewModel!
    
    init(with viewModel: CategoriesScreenViewModel) {
        super.init(nibName: String(describing: CategoryViewController.self), bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        initTableView()
        bindActivity()
    }
    
}

extension CategoryViewController :UITableViewDelegate{
    private func initTableView(){
        mainCategoryItems.delegate = nil
        mainCategoryItems.dataSource = nil
        mainCategoryItems.rx.setDelegate(self).disposed(by: disposeBag)
        
        let nib = UINib(nibName: "MainCategoryCellTableViewCell", bundle: nil)
        mainCategoryItems.separatorStyle = .none
        mainCategoryItems.register(nib, forCellReuseIdentifier: MainCategoryCellTableViewCell.identifier)
        setupReactiveMainCategoryTableData()
    }
    private func deselectAllRows(selectedIndex:Int ,animated: Bool) {
        for index in 0 ... mainCategoryItems.numberOfRows(inSection: 0)-1{
            let indexPath = IndexPath(row: index, section: 0)
            if(index != selectedIndex){
                let cell = mainCategoryItems.cellForRow(at: indexPath) as? MainCategoryCellTableViewCell
                cell?.cellContainerView.backgroundColor = .white
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectAllRows( selectedIndex : indexPath.row ,animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! MainCategoryCellTableViewCell
        cell.cellContainerView.backgroundColor = .blue
        cell.isSelected = true
        viewModel.categoryDetails.categoryID = cell.item?.id ?? 0
    }
    private func setupReactiveMainCategoryTableData(){
        viewModel.categories.drive(mainCategoryItems.rx.items(cellIdentifier: MainCategoryCellTableViewCell.identifier, cellType: MainCategoryCellTableViewCell.self)){ index , element , cell in
            if(index == 0){
                cell.cellContainerView.backgroundColor = .blue
            }
            cell.config(item: element)
        }.disposed(by: disposeBag)
    }
    
    private func bindActivity() {
        viewModel.isLoading.drive(ProgressHUD.rx.isAnimating)
        .disposed(by: disposeBag)
    }
}
extension CategoryViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 200)
    }
    
    func setupCollection(){
        categoriesCollectionView.delegate = nil
        categoriesCollectionView.dataSource = nil
        categoriesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        let nib = UINib(nibName: "CategoryItem", bundle: nil)
        categoriesCollectionView.register(nib, forCellWithReuseIdentifier: CategoryItem.identifier)
        viewModel.categoryDetails.productTypes.drive(categoriesCollectionView.rx.items(cellIdentifier: CategoryItem.identifier, cellType: CategoryItem.self)){[weak self] index , element , cell in
            guard let `self` = self else {fatalError()}
            cell.config(name: element , itemId: self.viewModel.categoryDetails.categoryID)
        }.disposed(by: disposeBag)
        
        categoriesCollectionView.rx.modelSelected(String.self).subscribe(onNext:{ type in
            let id = self.viewModel.categoryDetails.categoryID
            self.viewModel.gotToProductScreen(with: id, type: type)
        }).disposed(by: disposeBag)
    }
}
