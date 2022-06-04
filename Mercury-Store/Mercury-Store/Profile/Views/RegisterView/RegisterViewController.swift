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
        firstNameTextField.becomeFirstResponder()
               // cosmetics
               signUpBtn.setTitleColor(.gray, for: .disabled)
                       // rx
                       setupBindings()
                       observeViewModelOnValid()
           }
          
           func setupBindings() {
                  // 3
                  // bind textfields to viewModel for validation and process
               firstNameTextField.rx.text.bind(to:  registerViewModel.firstNameSubject).disposed(by: disposeBag)
               lastNameTextField.rx.text.bind(to:  registerViewModel.secondNameSubject).disposed(by: disposeBag)
               emailTextField.rx.text.bind(to:  registerViewModel.emailSubject).disposed(by: disposeBag)
               passwordTextField.rx.text.bind(to:  registerViewModel.passwordSubject).disposed(by: disposeBag)
               confirmPasswordTextField.rx.text.bind(to:  registerViewModel.confirmPasswordSubject).disposed(by: disposeBag)
                  
              }
           func observeViewModelOnValid(){
               // 4
               // check if form has fulfil conditions to enable submit button
            registerViewModel.isValidForm.bind(to:  signUpBtn.rx.isEnabled).disposed(by: disposeBag)
           }
          
           
       }
