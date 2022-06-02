//
//  GuestProfileViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 17/05/2022.
//

import UIKit

class GuestProfileViewController: UIViewController ,ProfileCoordinated{
    var coordinator: ProfileBaseCoordinator?
    init(coordinator: ProfileBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "guest"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var imagView: UIImageView!
    
    
    @IBAction func navToRegister(_ sender: Any){
        coordinator?.moveTo(flow: .profile(.registerScreen), userData: nil)

        
    }
    @IBAction func navToLogin(_ sender: Any){
        coordinator?.moveTo(flow: .profile(.loginScreen), userData: nil)
    }
    
}
