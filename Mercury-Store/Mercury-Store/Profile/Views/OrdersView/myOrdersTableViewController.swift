//
//  myOrdersTableViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 23/05/2022.
//

import UIKit
import RxSwift

class myOrdersTableViewController: UITableViewController {
    
    var ordersViewModel:DraftOrdersViewModelsType!
    let disposeBag = DisposeBag()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.ordersViewModel = DraftOrdersViewModels()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
    }
}
extension myOrdersTableViewController{
    func setupTable(){
        tableView.register(UINib(nibName: "MyOrdersViewCell", bundle: nil), forCellReuseIdentifier: "myOrderCell")
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        ordersViewModel.orders.drive(tableView.rx.items(
            cellIdentifier: "myOrderCell", cellType: MyOrdersViewCell.self)){index , element ,cell in
                cell.setupCell(order: element)
        }
    }
}
