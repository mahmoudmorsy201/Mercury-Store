//
//  UIImageView+Shadow.swift
//  Mercury-Store
//
//  Created by mac hub on 04/06/2022.
//

import UIKit.UIImageView

extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadius : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.borderColor = UIColor.clear.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.layer.shadowOffset = CGSize(width: 0, height: cornerRadius)
        containerView.layer.shadowRadius = 6.0
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
