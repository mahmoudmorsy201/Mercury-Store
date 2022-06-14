//
//  AddressViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 21/05/2022.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

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
       // bind()
        self.configure()
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
        }
       

        
    }
extension AddressViewController {
    private func configure() {
        self.bindTableView()
       
    }
}
