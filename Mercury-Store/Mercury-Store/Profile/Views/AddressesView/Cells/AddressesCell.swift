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

    var address: CustomerAddress? {
        didSet {
            guard let address = address else {
                return
            }
            addressLabel.text = address.address1
            cityLabel.text = address.city
            CountryLabel.text = address.countryName
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
