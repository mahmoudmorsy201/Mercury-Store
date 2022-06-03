//
//  RegisterViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 17/05/2022.
//

import UIKit
import TextFieldEffects
import RxCocoa
import RxSwift

class RegisterViewController: UIViewController {
    

    @IBOutlet weak var firstNameTextField: AkiraTextField!
    @IBOutlet weak var lastNameTextField: AkiraTextField!
    @IBOutlet weak var emailTextField: AkiraTextField!
    @IBOutlet weak var passwordTextField: AkiraTextField!
    @IBOutlet weak var confirmPasswordTextField: AkiraTextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    
    private let registerViewModel = RegisterViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.becomeFirstResponder()
        bindTextToViewModel()
        observeViewModelOnValid()
    }
    func bindTextToViewModel() {
        firstNameTextField.rx.text.map{ $0 ?? ""}.bind(to:registerViewModel.firstnameTextPublishSubject).disposed(by: disposeBag)
        lastNameTextField.rx.text.map{ $0 ?? ""}.bind(to:registerViewModel.lastnameTextPublishSubject).disposed(by: disposeBag)
        emailTextField.rx.text.map{ $0 ?? ""}.bind(to:registerViewModel.emailTextPublishSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map{ $0 ?? ""}.bind(to:registerViewModel.passwordTextPublishSubject).disposed(by: disposeBag)
        confirmPasswordTextField.rx.text.map{ $0 ?? ""}.bind(to:registerViewModel.confirmpasswordTextPublishSubject).disposed(by: disposeBag)
    }
    func observeViewModelOnValid(){
        registerViewModel.isValid().bind(to: signUpBtn.rx.isEnabled).disposed(by: disposeBag)
        registerViewModel.isValid().map{$0 ? 1: 1.0}.bind(to: signUpBtn.rx.alpha).disposed(by: disposeBag)
    }

    
    @IBAction func signUp(_ sender: Any) {

    }
    
}
