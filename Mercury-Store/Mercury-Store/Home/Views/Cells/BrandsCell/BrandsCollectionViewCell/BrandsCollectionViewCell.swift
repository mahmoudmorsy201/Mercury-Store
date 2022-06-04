//
//  BrandsCollectionViewCell.swift
//  Mercury-Store
//
//  Created by mac hub on 22/05/2022.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var containerViewForBrandsCollectionViewCell: UIView!
    @IBOutlet weak private var containerViewForBrandImageView: UIView!
    
    @IBOutlet weak private var brandImageView: UIImageView!
    
    @IBOutlet weak private var brandNameLabel: UILabel!
    
    var brandItem: SmartCollectionElement? {
        didSet {
            guard let brandItem = brandItem else {
                return
            }
            guard let url = URL(string: brandItem.image.src) else {
                return
            }
            brandImageView.downloadImage(url: url , placeholder: UIImage(named: "placeholder"), imageIndicator: .gray, completion: nil)
            brandNameLabel.text = brandItem.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        containerViewForBrandsCollectionViewCell.applyShadow(cornerRadius: 12)
        containerViewForBrandImageView.applyShadow(cornerRadius: 8)
    }

}
