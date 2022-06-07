//
//  MainProductsCollectionViewCell.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 04/06/2022.
//

import UIKit
import SDWebImage

class MainProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    var DetailedProductObject:Product!{
        didSet{
            productName.text = DetailedProductObject.title
            productPrice.text = DetailedProductObject.variants[0].price + " $"
            productPrice.font = UIFont.boldSystemFont(ofSize: 17)
            productImage.sd_setImage(with: URL(string: DetailedProductObject.image.src), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // self.collectionCellLayout()
    }

}
