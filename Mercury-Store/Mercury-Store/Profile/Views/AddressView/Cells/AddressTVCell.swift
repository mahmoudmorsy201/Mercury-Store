//
//  AddressTVCell.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 21/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class AddressTVCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var edit: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    
    var address: CustomerAddress? {
        didSet {
            guard let address = address else {
                return
            }
            addressLabel.text = address.address1
            cityLabel.text = address.city
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
   
    
}

