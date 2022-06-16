//
//  CreateAddressDetailsViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 22/05/2022.
//

import UIKit

class CreateAddressDetailsViewController: UIViewController {
   

    @IBOutlet weak var addAddressBtn: UIButton!
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var AddressTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    
    private var viewModel: AddressViewModelType!
    
    init(with viewModel: AddressViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func didPressedOnAddAddress(_ sender: Any) {
        let user = viewModel.getUserFromUserDefaults()
//        viewModel.postAddress(AddressRequestItem(address1: AddressTxt!.text!, address2: AddressTxt!.text!, city: cityTxt!.text!, company: "iti", firstName:user!.username, lastName: user!.username, phone: phoneTxt!.text!, province: cityTxt!.text!, country: countryTxt!.text!, zip: "G1R 4P5", name: "\(user!.username)", provinceCode: "Cairo", countryCode: "EG", countryName: "Egypt"))
        self.viewModel.goToPaymentScreen(itemsPrice: 5.5)
    }
}
