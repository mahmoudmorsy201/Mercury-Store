//
//  BannerCollectionViewCell.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var bannerImageView: UIImageView!
    
    private let disposeBag = DisposeBag()
    
    var item: String? {
        didSet {
            guard let item = item else {
                return
            }
            bannerImageView.image = UIImage(named: item)
        }
    }

     
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
