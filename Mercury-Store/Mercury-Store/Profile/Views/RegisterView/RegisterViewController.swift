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
import ProgressHUD

class RegisterViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var firstNameTextField: AkiraTextField!
    @IBOutlet weak var lastNameTextField: AkiraTextField!
    @IBOutlet weak var emailTextField: AkiraTextField!
    @IBOutlet weak var passwordTextField: AkiraTextField!
    @IBOutlet weak var confirmPasswordTextField: AkiraTextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    //MARK: - Private variables
    //
    private var registerViewModel: RegisterViewModelType!
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    //
    init(_ registerViewModel: RegisterViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.registerViewModel = registerViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpBtn.setTitleColor(.gray, for: .disabled)
        setupBindings()
        observeViewModelOnValid()
        bindSignUpBtn()
        bindLoginButton()
        bindErrorLabel()
        bindActivity()
        setUpUI()
    }
    
    //MARK: - Private Handlers
    //
    private func bindActivity() {
        registerViewModel.isLoading.drive(ProgressHUD.rx.isAnimating)
        .disposed(by: disposeBag)
    }
    
    private func setUpUI() {
        self.signUpBtn.tintColor = ColorsPalette.labelColors
        self.signUpBtn.configuration?.background.backgroundColor = ColorsPalette.lightColor
        loginButton.tintColor = ColorsPalette.lightColor
    }
    
    private func setupBindings() {
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
    
    private func observeViewModelOnValid() {
        registerViewModel.isValidForm.bind(to:  signUpBtn.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func bindSignUpBtn() {
        signUpBtn.rx.tap
            .subscribe {[weak self] _ in
            guard let `self` = self else {fatalError()}
            self.registerViewModel.checkCustomerExists(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!)
        }.disposed(by: disposeBag)
    }
    
    private func bindErrorLabel() {
        registerViewModel.emailCheckErrorMessage
            .bind(to: errorMessageLabel.rx.text)
            .disposed(by: disposeBag)
        
        registerViewModel.showErrorLabelObserver
            .bind(to: errorMessageLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private func bindLoginButton() {
        loginButton.rx.tap.subscribe { [weak self] _ in
            guard let `self` = self else {fatalError()}
            self.registerViewModel.goToLoginScreen()
        }.disposed(by: disposeBag)
    }
    
}
