//
//  LoginViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 30/05/2022.
//

import RxSwift
import RxCocoa

protocol LoginViewModelType {
    var emailObservable: AnyObserver<String?> { get }
    var passwordObservable: AnyObserver<String?> { get }
    var isValidForm: Observable<Bool> { get }
    var emailCheckErrorMessage: Observable<String?> { get }
    var showErrorLabelObserver: Observable<Bool> { get }
    func checkCustomerExists( email: String, password: String)
    func goToRegisterScreen()
}


class LoginViewModel: LoginViewModelType {
    
    private weak var registerNavigationFlow : GuestNavigationFlow?
    private let emailSubject = BehaviorSubject<String?>(value: "")
    private let passwordSubject = BehaviorSubject<String?>(value: "")
    private let disposeBag = DisposeBag()
    private let minPasswordCharacters = 6
    private let customerProvider: CustomerProvider
    private let customerRequestPostError = PublishSubject<Error>()
    private let showErrorMessage = PublishSubject<String?>()
    private let showErrorLabelSubject = BehaviorSubject<Bool>(value: true)
    private let customerRequestGet:PublishSubject<RegisterResponse> = PublishSubject<RegisterResponse>()
    
    var emailObservable: AnyObserver<String?> { emailSubject.asObserver() }
    
    var passwordObservable: AnyObserver<String?> { passwordSubject.asObserver() }
    
    var emailCheckErrorMessage: Observable<String?> { showErrorMessage.asObservable() }
    
    var showErrorLabelObserver: Observable<Bool> { showErrorLabelSubject.asObservable() }

    
    var isValidForm: Observable<Bool> {
        
        return Observable.combineLatest( emailSubject, passwordSubject) {  email, password in
            guard  email != nil && password != nil else {
                return false
            }
            
            return  email!.validateEmail() && password!.count >= self.minPasswordCharacters
        }
    }
    init(_ customerProvider: CustomerProvider = CustomerClient(),registerFlow:GuestNavigationFlow) {
        self.customerProvider = customerProvider
        self.registerNavigationFlow = registerFlow
    }
    func checkCustomerExists( email: String, password: String) {
        customerProvider.checkEmailExists(email)
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else {fatalError()}
                if(!result.customers.isEmpty) {
                    
                } else {
                    self.showErrorLabelSubject.onNext(false)
                    self.showErrorMessage.onNext(CustomerErrors.emailNotExists.rawValue)
                }
                
            }, onError: { [weak self] error in
                guard let `self` = self else {fatalError()}
                self.customerRequestPostError.onNext(error)
            }).disposed(by: disposeBag)
    }
    func goToRegisterScreen() {
        registerNavigationFlow?.goToRegistrationScreen()
    }
    
    
}
extension String {
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
