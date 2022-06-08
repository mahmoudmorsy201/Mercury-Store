//
//  RegisterViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 30/05/2022.
//

import RxSwift
import RxCocoa

protocol RegisterViewModelType {
    var firstNameObservable: AnyObserver<String?> { get }
    var secondNameObservable: AnyObserver<String?> { get }
    var emailObservable: AnyObserver<String?> { get }
    var passwordObservable: AnyObserver<String?> { get }
    var confirmPasswordObservable: AnyObserver<String?> { get }
    var isValidForm: Observable<Bool> { get }
}

class RegisterViewModel: RegisterViewModelType {

    private let firstNameSubject = BehaviorSubject<String?>(value: "")
    private let secondNameSubject = BehaviorSubject<String?>(value: "")
    private let emailSubject = BehaviorSubject<String?>(value: "")
    private let passwordSubject = BehaviorSubject<String?>(value: "")
    private let confirmPasswordSubject = BehaviorSubject<String?>(value: "")
    private let disposeBag = DisposeBag()
    private let minPasswordCharacters = 6
    
    var firstNameObservable: AnyObserver<String?> { firstNameSubject.asObserver() }
    
    var secondNameObservable: AnyObserver<String?> { secondNameSubject.asObserver() }
    
    var emailObservable: AnyObserver<String?> { emailSubject.asObserver() }
    
    var passwordObservable: AnyObserver<String?> { passwordSubject.asObserver() }
    
    var confirmPasswordObservable: AnyObserver<String?> { confirmPasswordSubject.asObserver() }

    var isValidForm: Observable<Bool> {
        return Observable.combineLatest( firstNameSubject, secondNameSubject,emailSubject, passwordSubject,confirmPasswordSubject) { firstName, secondName, email, password, confirmPassword in
            guard firstName != nil && secondName != nil && email != nil && password != nil && confirmPassword != nil else {
                return false
            }
            return !(firstName!.isEmpty) &&  !(secondName!.isEmpty) && email!.validateEmail() && password!.count >= self.minPasswordCharacters && confirmPassword!.count >= self.minPasswordCharacters
        }
    }
    
}
