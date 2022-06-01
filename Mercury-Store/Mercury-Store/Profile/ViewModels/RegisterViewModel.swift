//
//  RegisterViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 30/05/2022.
//

import RxSwift
import RxCocoa

class RegisterViewModel{
    let firstnameTextPublishSubject = PublishSubject<String>()
    let lastnameTextPublishSubject = PublishSubject<String>()
    let emailTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    let confirmpasswordTextPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(
                emailTextPublishSubject.asObservable(),
                passwordTextPublishSubject.asObservable(),
                firstnameTextPublishSubject.asObservable(),
                lastnameTextPublishSubject.asObservable(),
                confirmpasswordTextPublishSubject.asObservable()
            ).map{ email, password, firstname, lastname, confirmPassword in
                return [email, password, firstname, lastname, confirmPassword]
                    .filter { $0.count > 3 }
                    .isEmpty
            }.startWith(false)
    }
    
}
