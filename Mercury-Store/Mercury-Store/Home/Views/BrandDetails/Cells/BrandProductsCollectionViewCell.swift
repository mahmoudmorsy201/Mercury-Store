//
//  BrandProductsCollectionViewCell.swift
//  Mercury-Store
//
//  Created by mac hub on 01/06/2022.
//

import UIKit

class BrandProductsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak private var containerViewForBrandProductsCell: UIView!
    
    
    @IBOutlet weak private var productForBrandImage: UIImageView!
    
    @IBOutlet weak private var favouriteButton: UIButton!
    
    @IBOutlet weak private var productForBrandName: UILabel!
    
    @IBOutlet weak private var currencyLabel: UILabel!
    
    @IBOutlet weak private var productForBrandPrice: UILabel!
    
    var item: Product? {
        didSet {
            guard let item = item else {
                return
            }
            guard let url = URL(string: item.image.src) else {
                return
            }
            productForBrandImage.downloadImage(url: url , placeholder: UIImage(named: "placeholder"), imageIndicator: .gray, completion: nil)
            productForBrandName.text = item.title
            productForBrandPrice.text = item.variants[0].price
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
    }

}

//MARK: Private Handlers
//
extension BrandProductsCollectionViewCell {
    private func setupView() {
        containerViewForBrandProductsCell.layer.borderWidth = 0.5
        containerViewForBrandProductsCell.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        containerViewForBrandProductsCell.layer.cornerRadius = 12
        containerViewForBrandProductsCell.layer.masksToBounds = true
    }
}
