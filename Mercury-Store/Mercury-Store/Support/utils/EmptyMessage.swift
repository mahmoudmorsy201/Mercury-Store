//
//  EmptyMessage.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 24/05/2022.
//

import Foundation
import UIKit

func EmptyMessage(message:String, viewController:UICollectionViewController) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: viewController.view.bounds.size.width , height: viewController.view.bounds.size.width))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        viewController.collectionView.backgroundView = messageLabel;
    }
