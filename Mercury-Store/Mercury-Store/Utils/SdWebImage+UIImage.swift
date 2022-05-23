//
//  SdWebImage+UIImage.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

import SDWebImage
import UIKit.UIImage

class ImageDownloaderHelper {
    class func imageDownloadHelper(_ imageView: UIImageView, _ urlString: String) {
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "placeholder"))
    }
}
