//
//  RegisterViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 30/05/2022.
//

import RxSwift
import RxCocoa

class RegisterViewModel{
    // 1
           // Create subjects/observable
           let firstNameSubject = BehaviorRelay<String?>(value: "")
           let secondNameSubject = BehaviorRelay<String?>(value: "")
           let emailSubject = BehaviorRelay<String?>(value: "")
           let passwordSubject = BehaviorRelay<String?>(value: "")
           let confirmPasswordSubject = BehaviorRelay<String?>(value: "")
           let disposeBag = DisposeBag()
           let minPasswordCharacters = 6
           
           // 2
           // Observable - combine few conditions
           var isValidForm: Observable<Bool> {
               // check if name is valid not empty
               // valid email
               // password >= N
               return Observable.combineLatest( firstNameSubject, secondNameSubject,emailSubject, passwordSubject,confirmPasswordSubject) { firstName, secondName, email,password,confirmPassword in
                   guard firstName != nil && secondName != nil && email != nil && password != nil && confirmPassword != nil else {
                       return false
                   }
                   // Conditions:
                   // name not empty
                   // email is valid
                   // password greater or equal to specified
                   return !(firstName!.isEmpty) &&  !(secondName!.isEmpty) && email!.validateEmail() && password!.count >= self.minPasswordCharacters && confirmPassword!.count >= self.minPasswordCharacters
               }
           }
        
    }
