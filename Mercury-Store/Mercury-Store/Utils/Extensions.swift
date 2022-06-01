//
//  Extensions.swift
//  Mercury-Store
//
//  Created by mac hub on 22/05/2022.
//

import UIKit

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

extension UIView {
    func applyShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func makeCircularView() {
        self.layer.cornerRadius = self.layer.bounds.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.darkGray.cgColor
        //self.layer.borderWidth = 1.0
    }
    
    func makeCorners(corners: UIRectCorner , radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        }else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func applyShaow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    
}





