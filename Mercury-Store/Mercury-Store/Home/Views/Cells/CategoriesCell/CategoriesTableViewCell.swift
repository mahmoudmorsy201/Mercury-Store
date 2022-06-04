//
//  CategoriesTableViewCell.swift
//  Mercury-Store
//
//  Created by mac hub on 17/05/2022.
//

import UIKit
import RxSwift

class CategoriesTableViewCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak private var categoriesCollectionView: UICollectionView! {
        didSet {
            categoriesCollectionView.register(UINib(nibName: CategoriesCollectionViewCell.reuseIdentifier(), bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.reuseIdentifier())
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var viewModel: CategoriesViewModel? {
        didSet {
            self.configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CategoriesTableViewCell {
    private func bindCollectionView() {
        categoriesCollectionView.dataSource = nil
        categoriesCollectionView.delegate = nil
        categoriesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel?.categories
            .drive(categoriesCollectionView.rx.items(cellIdentifier: CategoriesCollectionViewCell.reuseIdentifier(), cellType: CategoriesCollectionViewCell.self)) {indexPath, item , cell in
                cell.category = item
            }
            .disposed(by: disposeBag)
        viewModel?.getCategories()
    }
    private func bindSelectedItem() {
        categoriesCollectionView.rx.modelSelected(CategoryDataItem.self).subscribe(onNext:{[weak self] item in
            guard let `self` = self else {fatalError()}
            self.viewModel?.goToFilteredProductScreen(with: item.id)
            
        }).disposed(by: disposeBag)
    }
}

extension CategoriesTableViewCell {
    private func configure() {
        self.bindCollectionView()
        self.bindSelectedItem()
    }
}

