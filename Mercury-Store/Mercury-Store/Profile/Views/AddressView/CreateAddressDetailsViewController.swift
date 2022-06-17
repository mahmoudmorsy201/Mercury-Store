//
//  CreateAddressDetailsViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 22/05/2022.
//

import UIKit
import Toast_Swift
import RxSwift
import RxCocoa
import TextFieldEffects

class CreateAddressDetailsViewController: UIViewController {
   
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var addAddressBtn: UIButton!
    @IBOutlet weak var countryTxt: AkiraTextField!
    @IBOutlet weak var cityTxt: AkiraTextField!
    @IBOutlet weak var AddressTxt: AkiraTextField!
    @IBOutlet weak var phoneTxt: AkiraTextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    private var viewModel: AddressViewModelType!
    private let disposeBag = DisposeBag()
    
    init(with viewModel: AddressViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        observeViewModelOnValid()
        bindCloseButton()
        bindErrorLabel()
        
    }
  
    private func bindCloseButton() {
        closeButton.rx.tap
            .subscribe {[weak self] _ in
                self?.viewModel.popViewController()
            }.disposed(by: disposeBag)
    }
    func setupBindings() {
        cityTxt.rx.text.bind(to: viewModel.cityObservable).disposed(by: disposeBag)
        countryTxt.rx.text.bind(to: viewModel.countryObservable).disposed(by: disposeBag)
        AddressTxt.rx.text.bind(to: viewModel.addressObservable).disposed(by: disposeBag)
        phoneTxt.rx.text.bind(to: viewModel.phoneObservable).disposed(by: disposeBag)
    }
    
    func  observeViewModelOnValid(){
        viewModel.isValidForm.bind(to: addAddressBtn.rx.isEnabled).disposed(by: disposeBag)
    }
    
    @IBAction func didPressedOnAddAddress(_ sender: Any) {
        let user = viewModel.getUserFromUserDefaults()
        viewModel.postAddress(AddressRequestItem(address1: AddressTxt!.text!, address2: AddressTxt!.text!, city: cityTxt!.text!, company: "iti", firstName:user!.username, lastName: user!.username, phone: phoneTxt!.text!, province: cityTxt!.text!, country: countryTxt!.text!, zip: "G1R 4P5", name: "\(user!.username)", provinceCode: "Cairo", countryCode: "EG", countryName: "Egypt"))
          self.view.makeToast("You Have Created address!", duration: 3.0, position: .bottom)

    }
    
    private func bindErrorLabel() {
        viewModel.addressErrorMessage
            .bind(to: errorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.showErrorLabelObserver
            .bind(to: errorLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
}
