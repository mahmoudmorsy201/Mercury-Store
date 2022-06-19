//
//  MyOrdersViewCell.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 22/05/2022.
//

import UIKit

class MyOrdersViewCell: UITableViewCell {
    // MARK: - IBOutlets
    //
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var paid: UILabel!
    @IBOutlet weak var price: UILabel!
    // MARK: - Life cycle
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func setupCell(order: DraftOrderTest){
        //createdAt.text = "\(order.name) \(order.createdAt.formatted(.dateTime))"
        //price.text = "Order total price: \(order.totalPrice) \(order.currency)"
       // paid.text = "order state: \(order.fulfillmentStatus)"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
