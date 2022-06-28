//
//  MySettingsViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 28/06/2022.
//

import UIKit
import RxSwift
import RxCocoa
import DropDown

class MySettingsViewController: UIViewController {

    @IBOutlet weak var settingsImageView: UIImageView!
    @IBOutlet weak var currencyDropDownButton: UIButton!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    private let disposeBag = DisposeBag()
    private let dropDown = DropDown()
    private let currencyDropDownArray = ["EGP" , "USD"]
    private var userDefaultStandard: UserDefaults!
    init(_ userDefaultStandard: UserDefaults = UserDefaults.standard) {
        super.init(nibName: nil, bundle: nil)
        self.userDefaultStandard = userDefaultStandard
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        dropDown.anchorView = currencyDropDownButton
        dropDown.dataSource = currencyDropDownArray
        let currency = userDefaultStandard.string(forKey: "currency")
        let index = dropDown.dataSource.firstIndex(of: currency!)
        dropDown.selectRow(at: index!)
        self.currencyDropDownButton.titleLabel?.text = currency
    }
    
    
    
}
