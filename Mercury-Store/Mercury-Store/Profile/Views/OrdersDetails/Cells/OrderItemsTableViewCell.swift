//
//  OrderItemsTableViewCell.swift
//  Mercury-Store
//
//  Created by mac hub on 29/06/2022.
//

import UIKit

class OrderItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderItemImageView: UIImageView!
    @IBOutlet weak var orderItemTitleLabel: UILabel!
    @IBOutlet weak var orderItemPrice: UILabel!
    @IBOutlet weak var orderItemQuantity: UILabel!
    
    var item: OrdersInfoLineItem? {
        didSet {
            guard let item = item else {
                return
            }
            orderItemImageView.downloadImage(url: URL(string: item.properties[0].imageName)! , placeholder: UIImage(named: "placeholder"), imageIndicator: .gray , completion: nil)
            orderItemTitleLabel.text = item.title
            orderItemPrice.text =  item.price
            orderItemQuantity.text = "\(item.quantity)"
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
