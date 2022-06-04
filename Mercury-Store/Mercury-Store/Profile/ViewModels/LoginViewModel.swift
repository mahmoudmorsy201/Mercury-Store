//
//  LoginViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 30/05/2022.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    
    // 1
            // Create subjects/observable
            let emailSubject = BehaviorRelay<String?>(value: "")
            let passwordSubject = BehaviorRelay<String?>(value: "")
            let disposeBag = DisposeBag()
            let minPasswordCharacters = 6
        // 2
            // Observable - combine few conditions
            var isValidForm: Observable<Bool> {
                // valid email
                // password >= N
                return Observable.combineLatest( emailSubject, passwordSubject) {  email, password in
                    guard  email != nil && password != nil else {
                        return false
                    }
                    // Conditions:
                    // email is valid
                    // password greater or equal to specified
                    return  email!.validateEmail() && password!.count >= self.minPasswordCharacters
                }
            }
        
    }
    extension String {
        func validateEmail() -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return predicate.evaluate(with: self)
        }
    }
