//
//  ShoppingCartTableViewCell.swift
//  Mercury-Store
//
//  Created by mac hub on 26/05/2022.
//

import UIKit

class ShoppingCartTableViewCell: UITableViewCell {
    @IBOutlet weak private var containerViewForProductImage: UIView!
    
    @IBOutlet weak private var productImageCart: UIImageView!
    
    @IBOutlet weak private var productNameCart: UILabel!
    
    @IBOutlet weak var containerViewForShoppingCartCell: UIView!
    
    @IBOutlet weak private var productPriceCart: UILabel!
    
    @IBOutlet weak private var stackViewForQuantity: UIStackView!
    
    @IBOutlet weak private var quantityLabel: UILabel!
    
    @IBOutlet weak private var increaseQuntityBtn: UIButton!
    
    
    @IBOutlet weak private var decreaseQuantityBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    var shoppingItem: ShoppingCartItem? {
        didSet {
            guard let shoppingItem = shoppingItem else {
                return
            }
            productNameCart.text = shoppingItem.productName
            productPriceCart.text = "\(shoppingItem.productPrice)"
            productImageCart.image = UIImage(named: shoppingItem.imageName)
            quantityLabel.text = "\(shoppingItem.quantity)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupCell() {
        self.containerViewForShoppingCartCell.applyShadow(cornerRadius: 12)
        self.productImageCart.layer.cornerRadius = 12
        self.containerViewForShoppingCartCell.layer.borderWidth = 0.5
        self.containerViewForShoppingCartCell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.stackViewForQuantity.layer.cornerRadius = 8
        self.productImageCart.layer.borderWidth = 0.5
        self.productImageCart.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
