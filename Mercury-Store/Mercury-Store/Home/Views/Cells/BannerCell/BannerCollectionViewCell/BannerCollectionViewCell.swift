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
    
    @IBOutlet weak var cellCOntainer: UIView!
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
        assignbackground()
        useThisDiscount.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else{return}
            if(self.viewModel.savePriceRole(itemId: self.item!.id)){
                self.presentSavingState()
            }else{
                self.presentErrorSAvingData()
            }
        }).disposed(by: disposeBag)
    }
    func assignbackground(){
        let background = UIImage(named: "offer_background")
        var imageView : UIImageView!
        imageView = UIImageView(frame: cellCOntainer.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = 0.3
        imageView.image = background
        imageView.center = cellCOntainer.center
        cellCOntainer.addSubview(imageView)
        self.cellCOntainer.sendSubviewToBack(imageView)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func presentSavingState(){
        let dialogMessage = UIAlertController(title: "", message: "your coupon was saved Succefully", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        dialogMessage.addAction(ok)
        guard let parentVC = self.parentViewController else { return }
        parentVC.present(dialogMessage, animated: true, completion: nil)
    }
    func presentErrorSAvingData(){
        let dialogMessage = UIAlertController(title: "", message: "something went wrong while savong coupon", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        dialogMessage.addAction(ok)
        guard let parentVC = self.parentViewController else { return }
        parentVC.present(dialogMessage, animated: true, completion: nil)
    }
}
