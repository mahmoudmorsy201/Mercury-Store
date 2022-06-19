//
//  AddressesCheckViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 16/06/2022.
//

import UIKit
import RxSwift

class AddressesCheckViewController: UIViewController {
    // MARK: - IBOutlets
    //
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var imageForEmptyAddress: UIImageView!
    @IBOutlet weak var tableView: UITableView!{
    didSet {
        tableView.register(UINib(nibName: AddressesCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: AddressesCell.reuseIdentifier())
    }}
    // MARK: - Properties
    //
    private var viewModel: AddressViewModelType!
    private let disposeBag = DisposeBag()
    // MARK: - Set up
    //
    init(with viewModel: AddressViewModelType! ) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    //
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
// MARK: - Extensions
extension AddressesCheckViewController {
    // MARK: - Private handlers
    //
    private func createAddBarButtonItem() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
        self.navigationItem.rightBarButtonItem = add
    }
    
    @objc func addBtnTapped() {
        self.viewModel.goToAddAddressScreen()
    }
}
// MARK: - Extensions
extension AddressesCheckViewController {
    // MARK: - Private handlers
    //
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
// MARK: - Extensions
extension AddressesCheckViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

