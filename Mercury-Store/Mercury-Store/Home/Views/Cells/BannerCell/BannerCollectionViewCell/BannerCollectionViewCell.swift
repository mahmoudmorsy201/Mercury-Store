 //
//  BannerCollectionViewCell.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var discountValueLabel: UILabel!
    
    @IBOutlet weak var useThisDiscount: UIButton!
    @IBOutlet weak var discountTitleLabel: UILabel!
    private var viewModel:PriceRoleCellViewModelType!
    private let disposeBag = DisposeBag()
    
    var item: PriceRule? {
        didSet {
            guard let item = item else {
                return
            }
            setupCellData(item: item)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = PriceRoleCellViewModel(_userDefaults: UserDefaults())
    }
    
    func setupCellData(item:PriceRule){
        discountValueLabel.text = "get \(item.value) Off "
        discountTitleLabel.text = "By \(item.title) Coupon"
        useThisDiscount.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else{return}
            self.viewModel.savePriceRole(itemId: self.item!.id)
        }).disposed(by: disposeBag)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
