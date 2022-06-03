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

    var item: ProductImage? {
        didSet {
            guard let item = item else {
                return
            }
            ImageDownloaderHelper.imageDownloadHelper(productImageDetails, item.src)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
