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
            ImageDownloaderHelper.imageDownloadHelper(brandImageView, brandItem.image.src)
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
