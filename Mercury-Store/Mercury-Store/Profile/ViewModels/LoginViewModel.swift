//
//  LoginViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 30/05/2022.
//

import RxSwift
import RxCocoa
import Foundation

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
    private let sharedInstance: UserDefaults
    
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
    
    init(_ customerProvider: CustomerProvider = CustomerClient(),sharedInstance: UserDefaults = UserDefaults.standard ,registerFlow: GuestNavigationFlow) {
        self.customerProvider = customerProvider
        self.registerNavigationFlow = registerFlow
        self.sharedInstance = sharedInstance
    }
    
    func checkCustomerExists( email: String, password: String) {
        customerProvider.checkEmailExists(email)
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else {fatalError()}
                self.checkResult(result, password: password)
            }, onError: { [weak self] error in
                guard let `self` = self else {fatalError()}
                self.customerRequestPostError.onNext(error)
            }).disposed(by: disposeBag)
    }
    
    func goToRegisterScreen() {
        registerNavigationFlow?.goToRegistrationScreen()
    }
        
    private func checkResult(_ result: AllCustomers, password: String) {
        if(!result.customers.isEmpty) {
            checkPassword(password, result)
        } else {
            self.showErrorLabelSubject.onNext(false)
            self.showErrorMessage.onNext(CustomerErrors.emailNotExists.rawValue)
        }
    }
    
    private func goToProfileScreen(_ id: Int) {
        self.registerNavigationFlow?.isLoggedInSuccessfully(id)
    }
    
    private func checkPassword(_ password: String, _ result: AllCustomers) {
        let matched = result.customers.map{ $0.password }.filter{ $0 == password }
        if(matched.contains{$0 == password}) {
            let customer = result.customers[0]
            self.saveCredentialsInUserDefaults(customer: customer)
            self.goToProfileScreen(customer.id)
        }else {
            self.showErrorLabelSubject.onNext(false)
            self.showErrorMessage.onNext(CustomerErrors.checkYourCredentials.rawValue)
        }
    }
    
    private func saveCredentialsInUserDefaults(customer: CustomerResponse) {
        let user = fromCustomerToUser(customer)
        do {
            try sharedInstance.setObject(user, forKey: "user")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fromCustomerToUser(_ customer: CustomerResponse) -> User {
        return User(id: customer.id, email: customer.email, username: customer.firstName, isLoggedIn: true, isDiscount: false, password: customer.password, cartId: Int(customer.cartId ?? "") ?? 0, favouriteId: Int(customer.favouriteId ?? "0") ?? 0)
    }
    
    
    
}
