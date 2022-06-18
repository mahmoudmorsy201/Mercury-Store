//
//  AddressesCheckViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 16/06/2022.
//

import UIKit
import RxSwift

class AddressesCheckViewController: UIViewController {
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var imageForEmptyAddress: UIImageView!
    @IBOutlet weak var tableView: UITableView!{
    didSet {
        tableView.register(UINib(nibName: AddressesCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: AddressesCell.reuseIdentifier())
    }}
    
    private var viewModel: AddressViewModelType!
    private let disposeBag = DisposeBag()
    
    init(with viewModel: AddressViewModelType! ) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
        bindEmptyView()
        createAddBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.getAddress()
    }
}

extension AddressesCheckViewController {
    
    private func createAddBarButtonItem() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
        self.navigationItem.rightBarButtonItem = add
    }
    
    @objc func addBtnTapped() {
        self.viewModel.goToAddAddressScreen()
    }
}

extension AddressesCheckViewController {
    private func bindTableView() {
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.addresses
            .drive(tableView.rx.items(cellIdentifier: AddressesCell.reuseIdentifier(), cellType: AddressesCell.self)) {indexPath, item , cell in
                cell.address = item
            }
            .disposed(by: disposeBag)
        self.viewModel?.getAddress()
    }
    
    private func bindEmptyView() {
        self.viewModel.empty
            .drive(emptyView.rx.isHidden)
            .disposed(by: disposeBag)
    }
}

extension AddressesCheckViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

