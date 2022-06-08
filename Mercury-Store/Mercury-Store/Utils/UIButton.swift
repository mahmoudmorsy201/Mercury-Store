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
            print("fav")
            setImage(UIImage(systemName:"heart.fill"), for: [])
            self.imageView?.tintColor = .red
        }else {
            print("not fav")
            setImage(UIImage(systemName:"heart"), for: [])
            //self.imageView?.image = UIImage(systemName: "heart")
        }
    }
}
