//
//  RegisterViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 17/05/2022.
//

import UIKit
import TextFieldEffects
class RegisterViewController: UIViewController,ProfileCoordinated{
    
    @IBOutlet weak var firstNameTextField: AkiraTextField!
    
    @IBOutlet weak var lastNameTextField: AkiraTextField!
    @IBOutlet weak var emailTextField: AkiraTextField!
    @IBOutlet weak var passwordTextField: AkiraTextField!
    @IBOutlet weak var confirmPasswordTextField: AkiraTextField!
    @IBOutlet weak var loginLabel: UILabel!
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

        // Do any additional setup after loading the view.
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
        
    coordinator?.moveTo(flow: .profile(.registerScreen), userData: nil)

    }
    
}
