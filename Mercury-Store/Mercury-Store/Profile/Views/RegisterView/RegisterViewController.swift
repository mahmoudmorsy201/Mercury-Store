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
    
    private var registerViewModel: RegisterViewModelType!
    private let disposeBag = DisposeBag()
    
    init(_ registerViewModel: RegisterViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.registerViewModel = registerViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // cosmetics
        signUpBtn.setTitleColor(.gray, for: .disabled)
        // rx
        setupBindings()
        observeViewModelOnValid()
    }
    
    func setupBindings() {
        // 3
        // bind textfields to viewModel for validation and process
        firstNameTextField.rx.text
            .bind(to: registerViewModel.firstNameObservable)
            .disposed(by: disposeBag)
        
        
        lastNameTextField.rx.text
            .bind(to: registerViewModel.secondNameObservable)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .bind(to: registerViewModel.emailObservable)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .bind(to: registerViewModel.passwordObservable)
            .disposed(by: disposeBag)
        
        confirmPasswordTextField.rx.text
            .bind(to: registerViewModel.confirmPasswordObservable)
            .disposed(by: disposeBag)
        
    }
    
    func observeViewModelOnValid() {
        registerViewModel.isValidForm.bind(to:  signUpBtn.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
