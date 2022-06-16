//
//  AddressesCell.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 16/06/2022.
//

import UIKit

class AddressesCell: UITableViewCell {
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var CountryLabel: UILabel!
    
    @IBOutlet weak var isCheckedAddr: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
