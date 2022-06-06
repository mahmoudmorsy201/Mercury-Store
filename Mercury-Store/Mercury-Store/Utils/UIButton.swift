//
//  UIButton.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 06/06/2022.
//

import Foundation
import UIKit
extension UIButton{
    func favouriteState(state:Bool){
        if(state){
            self.imageView?.image = UIImage(systemName: "heart.fill")!
            self.imageView?.tintColor = .red
        }else {
            self.imageView?.image = UIImage(systemName: "heart")
        }
    }
}
