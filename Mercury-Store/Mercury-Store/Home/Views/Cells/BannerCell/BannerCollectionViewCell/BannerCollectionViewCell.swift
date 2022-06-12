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
    var index: Int? {
        didSet {
            guard let index = index else {
                return
            }
            if (index+1)%2 == 0{
                print(index+1)
                assignbackground(imageName: "of1")
            }
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
        assignbackground()
        let tapGesture = UITapGestureRecognizer()
        cellCOntainer.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.subscribe(onNext: {[weak self] _ in
            guard let self = self else{return}
            if(self.viewModel.savePriceRole(itemId: self.item!.id)){
                self.presentSavingState()
            }else{
                self.presentErrorSAvingData()
            }
        }).disposed(by: disposeBag)
    }
    func assignbackground(imageName:String = "of1"){
        let background = UIImage(named: imageName)
        var imageView : UIImageView!
        imageView = UIImageView(frame: cellCOntainer.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = cellCOntainer.center
        cellCOntainer.addSubview(imageView)
        self.cellCOntainer.sendSubviewToBack(imageView)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func presentSavingState(){
        let msgPart2 = "your coupon was saved Succefully\n"
        let msgPart1 = "\(item!.title)\n"
        let dialogMessage = UIAlertController(title: "", message: "\(msgPart1) \(msgPart2)", preferredStyle: .alert)
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
