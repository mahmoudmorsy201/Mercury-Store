//
//  UpdateAddressViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 14/06/2022.
//

import UIKit
import TextFieldEffects
import Toast_Swift
import RxSwift
import RxCocoa

class UpdateAddressViewController: UIViewController {
    
    @IBOutlet weak var countryTxt: AkiraTextField!
    
    @IBOutlet weak var cityTxt: AkiraTextField!
    
    @IBOutlet weak var addressTxt: AkiraTextField!
    
    @IBOutlet weak var phoneTxt: AkiraTextField!
    
    @IBOutlet weak var updateAddrBtn: UIButton!
    private var viewModel: AddressViewModelType!
    private var selectedAddress: CustomerAddress!
    private let disposeBag = DisposeBag ()
    
    init(with viewModel: AddressViewModelType, selectedAddress: CustomerAddress) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.selectedAddress = selectedAddress
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       updateAddrBtn.setTitleColor(.gray, for: .disabled)
        setupUI()
        setupBindings()
        observeViewModelOnValid()
    }
    func setupBindings() {
        cityTxt.rx.text.bind(to: viewModel.cityObservable).disposed(by: disposeBag)
        countryTxt.rx.text.bind(to: viewModel.countryObservable).disposed(by: disposeBag)
        addressTxt.rx.text.bind(to: viewModel.addressObservable).disposed(by: disposeBag)
        phoneTxt.rx.text.bind(to: viewModel.phoneObservable).disposed(by: disposeBag)
    }
    
    func  observeViewModelOnValid(){
        viewModel.isValidForm.bind(to: updateAddrBtn.rx.isEnabled).disposed(by: disposeBag)
    }

    private func setupUI() {
        self.countryTxt.text = selectedAddress.country
        self.cityTxt.text = selectedAddress.city
        self.addressTxt.text = selectedAddress.address1
        self.phoneTxt.text = selectedAddress.phone
    }
   
    

    
    @IBAction func updateAddrBtn(_ sender: Any) {
        let user = viewModel.getUserFromUserDefaults()
        viewModel.updateAddress(AddressRequestItemPut(address1: addressTxt!.text!, address2: addressTxt!.text!, city: cityTxt!.text!, company: "iti", firstName: user!.username, lastName: user!.username, phone: phoneTxt!.text!, province: cityTxt!.text!, country: countryTxt!.text!, zip: "G1R 4P5", name: "\(user!.username)", provinceCode: "Cairo", countryCode: "EG", countryName: "Egypt", id: selectedAddress.id))
        self.view.makeToast("You Have Updated address!", duration: 3.0, position: .bottom)
    }
    
}
