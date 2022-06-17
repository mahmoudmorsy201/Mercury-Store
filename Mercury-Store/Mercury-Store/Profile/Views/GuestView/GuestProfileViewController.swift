//
//  GuestProfileViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 17/05/2022.
//

import UIKit
import RxSwift

class GuestProfileViewController: UIViewController {
    
    @IBOutlet weak private var imagView: UIImageView!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var registerButton: UIButton!
    
    private var viewModel: GuestViewModelType!
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    //
    init(_ viewModel: GuestViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindRegisterButtonTap()
        bindLoginButtonTap()
        setUpUI()
    }
    
    private func setUpUI() {
        self.registerButton.tintColor = ColorsPalette.labelColors
        self.registerButton.configuration?.background.backgroundColor = ColorsPalette.lightColor
        self.loginButton.tintColor = ColorsPalette.labelColors
        self.loginButton.configuration?.background.backgroundColor = ColorsPalette.lightColor
        self.imagView.tintColor = ColorsPalette.lightColor
    }
}

//MARK: - Private Handlers
//

extension GuestProfileViewController {
    
    private func setupView() {
        loginButton.makeRoundedCornerButton()
        registerButton.makeRoundedCornerButton()
    }
    
    private func bindRegisterButtonTap() {
        registerButton.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.viewModel.registerButtonTapped()
        }).disposed(by: disposeBag)
    }
    
    private func bindLoginButtonTap() {
        loginButton.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.viewModel.loginButtonTapped()
        }).disposed(by: disposeBag)
    }
}
