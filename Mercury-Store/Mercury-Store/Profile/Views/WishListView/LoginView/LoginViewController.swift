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
        emailTextField.becomeFirstResponder()
                // cosmetics
                  loginButton.setTitleColor(.gray, for: .disabled)
                        // rx
                        setupBindings()
                       observeViewModelOnValid()
            }
            
          
            func setupBindings() {
                    // 3
                    // bind textfields to viewModel for validation and process
                    emailTextField.rx.text.bind(to: loginViewModel.emailSubject).disposed(by: disposeBag)
                    passwordTextField.rx.text.bind(to: loginViewModel.passwordSubject).disposed(by: disposeBag)
                    
                  
                }
            func  observeViewModelOnValid(){
                // 4
                // check if form has fulfil conditions to enable submit button
               loginViewModel.isValidForm.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
            }
            
        }
