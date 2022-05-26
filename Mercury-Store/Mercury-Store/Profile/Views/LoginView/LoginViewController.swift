//
//  LoginViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 17/05/2022.
//

import UIKit

class LoginViewController: UIViewController,ProfileCoordinated {
    
    var coordinator: ProfileBaseCoordinator?
    init(coordinator: ProfileBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "login"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
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
    
    @IBAction func loginPressed(_ sender: Any) {
        
        coordinator?.moveTo(flow: .profile(.loginScreen), userData: nil)
    }
    @IBAction func goToSignUp(_ sender: UIButton) {
        coordinator?.moveTo(flow: .profile(.registerScreen), userData: nil)

        
    }
    
}
