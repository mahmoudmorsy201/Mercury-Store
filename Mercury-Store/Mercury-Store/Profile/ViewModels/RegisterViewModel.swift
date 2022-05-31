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
        return Observable.combineLatest( emailTextPublishSubject.asObservable(), passwordTextPublishSubject.asObservable(),firstnameTextPublishSubject.asObservable(),lastnameTextPublishSubject.asObservable(),confirmpasswordTextPublishSubject.asObservable()).map{ email,password,firstname,lastname,confirmpassword in
            return email.count > 3 && password.count > 3 && firstname.count > 3 && lastname.count > 3 && confirmpassword.count > 3
        }.startWith(false)
    }
    
}
