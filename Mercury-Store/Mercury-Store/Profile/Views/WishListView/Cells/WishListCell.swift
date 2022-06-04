//
//  WishListCell.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 23/05/2022.
//

import UIKit

class WishListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var priceLable: UILabel!
    public static let identifier = "WishListCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(item:SavedProductItem){
        titleLable.text = item.productTitle
        priceLable.text = "\(item.productPrice)EGP"
        imgView.downloadImage(url: URL(string: item.productImage)! , placeholder: UIImage(named: "placeholder"), imageIndicator: .gray , completion: nil)
    }
    
}
