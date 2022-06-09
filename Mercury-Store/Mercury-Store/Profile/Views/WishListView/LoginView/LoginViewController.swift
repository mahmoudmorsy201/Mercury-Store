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
    
    private var loginViewModel: LoginViewModelType!
    private let disposeBag = DisposeBag ()
    
    init(_ loginViewModel: LoginViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.loginViewModel = loginViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.setTitleColor(.gray, for: .disabled)
                        
            setupBindings()
            observeViewModelOnValid()
           bindLoginBtn()
            }
            
          
            func setupBindings() {
                    // 3
                    // bind textfields to viewModel for validation and process
                    emailTextField.rx.text.bind(to: loginViewModel.emailObservable).disposed(by: disposeBag)
                    passwordTextField.rx.text.bind(to: loginViewModel.passwordObservable).disposed(by: disposeBag)
                    
                  
                }
            func  observeViewModelOnValid(){
               
               loginViewModel.isValidForm.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
            }
    private func  bindLoginBtn(){
        loginButton.rx.tap.subscribe { [weak self] _ in
            guard let `self` = self else {fatalError()}
            self.loginViewModel.getCustomer()
        }.disposed(by: disposeBag)
          

    }
            
        }
