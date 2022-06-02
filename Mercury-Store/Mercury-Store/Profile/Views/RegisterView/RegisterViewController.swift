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

class RegisterViewController: UIViewController,ProfileCoordinated{
    
    private let registerViewModel = RegisterViewModel()
    private let disposeBag = DisposeBag ()
    @IBOutlet weak var firstNameTextField: AkiraTextField!
    @IBOutlet weak var lastNameTextField: AkiraTextField!
    @IBOutlet weak var emailTextField: AkiraTextField!
    @IBOutlet weak var passwordTextField: AkiraTextField!
    @IBOutlet weak var confirmPasswordTextField: AkiraTextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    var coordinator: ProfileBaseCoordinator?
    init(coordinator: ProfileBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "register"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signUp(_ sender: Any) {
    print("Tapped Login Button")
    coordinator?.moveTo(flow: .profile(.intialScreen), userData: nil)

    }
    
}
