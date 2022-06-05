//
//  WishListViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 23/05/2022.
//

import UIKit
import RxSwift

class WishListViewController: UIViewController {
    
    let viewModel:WishListViewModelType = WishListViewModel()
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "WishListCell", bundle: nil), forCellReuseIdentifier: WishListCell.identifier)
        tableDataSource()
    }
   

}
extension WishListViewController : UITableViewDelegate{
    
    func tableDataSource(){
        viewModel.getFavouriteItems()
        viewModel.products.drive(tableView.rx.items(cellIdentifier: WishListCell.identifier , cellType: WishListCell.self)){ index , element , cell in
                cell.config(item: element)
            }.disposed(by: disposeBag)
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
}
