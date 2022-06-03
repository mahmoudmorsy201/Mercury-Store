//
//  LoginViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 17/05/2022.
//
import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.becomeFirstResponder()
        bindTextToViewModel()
        observeViewModelOnValid()
    }
    
    func bindTextToViewModel() {
        emailTextField
            .rx.text
            .map { $0 ?? "" }
            .bind(to: loginViewModel.emailTextPublishSubject)
            .disposed(by: disposeBag)
        
        passwordTextField
            .rx.text
            .map { $0 ?? "" }
            .bind(to: loginViewModel.passwordTextPublishSubject)
            .disposed(by: disposeBag)
    }
    
    func observeViewModelOnValid() {
        loginViewModel
            .isValid()
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginViewModel
            .isValid()
            .map{ $0 ? 1 : 1.0 }
            .bind(to: loginButton.rx.alpha)
            .disposed(by: disposeBag)
    }
    @IBAction func loginPressed(_ sender: Any) {
        
    }
    @IBAction func goToSignUp(_ sender: UIButton) {
        
    }
    
}
