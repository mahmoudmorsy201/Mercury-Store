//
//  UIImageView+SDWebImage.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

import SDWebImage
import UIKit.UIImageView

extension UIImageView {
    // Image download and cache using SDWebImage
    func downloadImage(url: URL, placeholder:UIImage?,imageIndicator:SDWebImageActivityIndicator, completion:((UIImage?, Error?) -> Void)?) {
        self.sd_imageIndicator = imageIndicator
        self.sd_setImage(with: url, placeholderImage: placeholder, options: .retryFailed, context: nil, progress: nil) { (img, error, cacheType, url) in
            if error != nil {
                if placeholder == nil {
                    self.image =  UIImage(named: "placeholder")
                } else {
                    self.image = placeholder
                }
            }
            if completion != nil {
                completion!(img, error)
            }
        }
    }
    
}
