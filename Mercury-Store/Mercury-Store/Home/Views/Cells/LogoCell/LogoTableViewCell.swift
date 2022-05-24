//
//  LogoTableViewCell.swift
//  Mercury-Store
//
//  Created by mac hub on 17/05/2022.
//

import UIKit
import RxSwift

class LogoTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var  logoImageView: UIImageView!
    @IBOutlet weak private var  containerViewForLogoImageView: UIView!
    
    var logoImageName: String? {
        didSet {
            logoImageView.image = UIImage(named: logoImageName!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}




