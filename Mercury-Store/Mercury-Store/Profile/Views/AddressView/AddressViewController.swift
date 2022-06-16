//
//  AddressViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 21/05/2022.
//

import UIKit
import RxCocoa
import RxSwift


class AddressViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!{
    didSet {
        tableView.register(UINib(nibName: AddressTVCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: AddressTVCell.reuseIdentifier())
    }}
    let disposeBag = DisposeBag()
   private var viewModel: AddressViewModelType!
    init(_  viewModel: AddressViewModelType){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.getAddress()
    }
    
}

    extension AddressViewController {
        private func bindTableView() {
            tableView.dataSource = nil
            tableView.delegate = nil
            tableView.rx.setDelegate(self).disposed(by: disposeBag)

            viewModel.addresses
                .drive(tableView.rx.items(cellIdentifier: AddressTVCell.reuseIdentifier(), cellType: AddressTVCell.self)) {indexPath, item , cell in
                    cell.address = item
                }
                .disposed(by: disposeBag)
            self.viewModel?.getAddress()
            
            
            tableView.rx.modelSelected(CustomerAddress.self)
                .subscribe(onNext:{ type in
                    self.viewModel.goToEditAddressScreen(with: type)
                }).disposed(by: disposeBag)
            
        }


        
    }
extension AddressViewController {
    private func configure() {
        self.bindTableView()
        
    }
}
extension AddressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

