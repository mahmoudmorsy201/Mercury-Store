//
//  RadioButtonCell.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 14/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

enum paymentOptions{
    case withPaypal
    case cashOnDelivery
}
class RadioButtonCell: UITableViewCell {
    override var reuseIdentifier: String?{
        "RadioButtonCell"
    }
    @IBOutlet weak var payPal: UIButton!
    @IBOutlet weak var cashOnDelivery: UIButton!
    let disposeBage = DisposeBag()
    var paymentMethod:paymentOptions = .cashOnDelivery
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
extension RadioButtonCell{
    
    private func payPalAction(){
        payPal.rx.tap.bind{ [ weak self ]  in
            guard let self = self else {return}
            self.payPal.imageView?.image = UIImage(systemName: "circle.inset.filled")
            self.cashOnDelivery.imageView?.image = UIImage(systemName: "circle")
            self.paymentMethod = .withPaypal
        }.disposed(by: disposeBage)
    }
    
    private func cashOnDeliveryAction(){
        cashOnDelivery.rx.tap.bind{ [ weak self ]  in
            guard let self = self else {return}
            self.payPal.imageView?.image = UIImage(systemName: "circle")
            self.cashOnDelivery.imageView?.image = UIImage(systemName: "circle.inset.filled")
            self.paymentMethod = .cashOnDelivery
        }.disposed(by: disposeBage)
    }
    
}
