//
//  AddressesCheckViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 16/06/2022.
//

import UIKit
import TextFieldEffects

class AddressesCheckViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
    didSet {
        tableView.register(UINib(nibName: AddressesCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: AddressesCell.reuseIdentifier())
    }}
    
    @IBOutlet weak var countryTxtField: AkiraTextField!
    
    @IBOutlet weak var cityTxtField: AkiraTextField!
    
    @IBOutlet weak var addressTxtField: AkiraTextField!
    
    @IBOutlet weak var phoneTxtField: AkiraTextField!
    
    @IBOutlet weak var addAddressBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
extension AddressesCheckViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}

