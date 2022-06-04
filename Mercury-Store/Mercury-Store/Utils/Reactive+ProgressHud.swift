//
//  Reactive+ProgressHud.swift
//  Mercury-Store
//
//  Created by mac hub on 04/06/2022.
//

import RxSwift
import ProgressHUD

extension Reactive where Base: ProgressHUD {

   public static var isAnimating: Binder<Bool> {
      return Binder(UIApplication.shared) {progressHUD, isVisible in
         if isVisible {
             ProgressHUD.show()
         } else {
             ProgressHUD.dismiss()
         }
      }
   }

}
