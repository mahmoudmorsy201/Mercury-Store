//
//  BannerTableViewCell.swift
//  Mercury-Store
//
//  Created by mac hub on 17/05/2022.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var containerViewForBannerImageView: UIView!
    
    @IBOutlet weak private var bannerImageView: UIImageView!
    
    var bannerImageName: String? {
        didSet {
            bannerImageView.image = UIImage(named: bannerImageName ?? "")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        self.contentView.applyShadow(cornerRadius: 8)
        self.containerViewForBannerImageView.layer.cornerRadius = 12
        self.containerViewForBannerImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
