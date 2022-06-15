//
//  UIViewController+UIAlertDelete.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 14/06/2022.
//

import UIKit
import RxSwift

struct AlertDeleteView {
    public static func showAlertBox(title: String, message: String, handler: ((UIAlertAction)->Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: handler))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: handler))
        
        return alert
    }
}

extension UIAlertController {
    func presentAlert(on viewController: UIViewController, completion: (() -> Void)? = nil) {
        viewController.present(self, animated: true, completion: completion)
    }
}
