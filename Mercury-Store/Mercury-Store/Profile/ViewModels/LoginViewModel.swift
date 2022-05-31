//
//  LoginViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 30/05/2022.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    
    let emailTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest( emailTextPublishSubject.asObservable(), passwordTextPublishSubject.asObservable()).map{ email,password in
            return email.count > 3 && password.count > 3
        }.startWith(false)
    }
}
