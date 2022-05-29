//
//  ProductCell.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 24/05/2022.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productIMG: UIImageView!
    @IBOutlet weak var cellContainingView: UIStackView!
    static let identifier = "ProductCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellContainingView.layer.cornerRadius = 15.0
        cellContainingView.layer.borderWidth = 1.0
        cellContainingView.layer.borderColor = UIColor.black.cgColor
        cellContainingView.layer.shadowColor = UIColor.black.cgColor
        cellContainingView.layer.shadowOffset = CGSize(width: 2, height: 2)
        cellContainingView.layer.shadowRadius = 5.0
        cellContainingView.layer.shadowOpacity = 1
        cellContainingView.layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    public func configure(item:Product){
        ImageDownloaderHelper.imageDownloadHelper(productIMG, item.image.src)
        productName.text = item.title
        productPrice.text = item.variants[0].price
    }

}
