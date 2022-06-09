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
    func getCustomer()
}


class LoginViewModel: LoginViewModelType {
    
            private let emailSubject = BehaviorSubject<String?>(value: "")
           private let passwordSubject = BehaviorSubject<String?>(value: "")
            private let disposeBag = DisposeBag()
          private let minPasswordCharacters = 6
    private let customerProvider: CustomerProvider
    private let customerRequestGet:PublishSubject<RegisterResponse> = PublishSubject<RegisterResponse>()
    
    var emailObservable: AnyObserver<String?> { emailSubject.asObserver() }
    
    var passwordObservable: AnyObserver<String?> { passwordSubject.asObserver() }
    
        
            var isValidForm: Observable<Bool> {
                
                return Observable.combineLatest( emailSubject, passwordSubject) {  email, password in
                    guard  email != nil && password != nil else {
                        return false
                    }
                   
                    return  email!.validateEmail() && password!.count >= self.minPasswordCharacters
                }
            }
    init(_ customerProvider: CustomerProvider = CustomerClient()) {
        self.customerProvider = customerProvider
    }
    func getCustomer(){
        customerProvider.getCustomer(
            id:6256082157826)
        .subscribe(onNext: {[weak self] result in
            guard let `self` = self else {fatalError()}
            self.customerRequestGet.onNext(result)
            print(result)
        }).disposed(by: disposeBag)
        
        
    }
        
    }
    extension String {
        func validateEmail() -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return predicate.evaluate(with: self)
        }
    }
