//
//  WishListViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 23/05/2022.
//

import UIKit
import RxSwift

class WishListViewController: UIViewController {
    
    // MARK: - IBOutlets
    //
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    //
    let viewModel:WishListViewModelType = WishListViewModel()
    let disposeBag = DisposeBag()
    // MARK: - Life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "WishListCell", bundle: nil), forCellReuseIdentifier: WishListCell.identifier)
        tableDataSource()
    }

}
// MARK: - Extensions
extension WishListViewController : UITableViewDelegate{
    // MARK: - Private handlers
    //
    func tableDataSource(){
        viewModel.getFavouriteItems()
        viewModel.products.drive(tableView.rx.items(cellIdentifier: WishListCell.identifier , cellType: WishListCell.self)){ index , element , cell in
                cell.config(item: element)
            cell.deleteCallback = {[weak self] item in
                self?.viewModel.deleteItem(item: item)
            }
            self.viewModel.isFavouriteItem(productID: (element.productID as NSDecimalNumber).intValue)
        }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
}
