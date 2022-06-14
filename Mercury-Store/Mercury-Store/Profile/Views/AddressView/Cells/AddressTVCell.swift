//
//  AddressTVCell.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 21/05/2022.
//

import UIKit

class AddressTVCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    
    var address: CustomerAddress? {
        didSet {
            guard let address = address else {
                return
            }
            addressLabel.text = address.name
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    public func config(name:String , itemId:Int){
        addressLabel.text = name
        
    }
    
}
