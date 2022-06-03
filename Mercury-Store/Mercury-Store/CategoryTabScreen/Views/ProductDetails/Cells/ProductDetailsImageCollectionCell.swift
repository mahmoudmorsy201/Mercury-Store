//
//  ProductDetailsImageCollectionCell.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 03/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailsImageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var productImageDetails: UIImageView!
    private let disposeBag = DisposeBag()

    //static let identifier = "ProductDetailsImageCollectionCell"
    /*static func nib()->UINib{
        return UINib(nibName: identifier, bundle: nil)
    }*/
    var item: ProductImage? {
        didSet {
            guard let item = item else {
                return
            }
            productImageDetails.image = UIImage(named: item.src)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
