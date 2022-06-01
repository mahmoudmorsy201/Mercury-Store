//
//  ShoppingCartViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class ShoppingCartViewController: UIViewController, ShoppingCartCoordinated {
    
    @IBOutlet weak private var totalPriceLabel: UILabel!
    
    @IBOutlet weak var checkoutBottom: NSLayoutConstraint!
    
    @IBOutlet weak private var shoppingCartTableView: UITableView! {
        didSet {
            shoppingCartTableView.register(UINib(nibName: ShoppingCartTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: ShoppingCartTableViewCell.reuseIdentifier())
        }
    }
    
    @IBOutlet weak var proceedToCheckoutBtn: UIButton!
    
    var coordinator: ShoppingCartBaseCoordinator?
    private let viewModel = CartViewModel()
    
    init(coordinator: ShoppingCartBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Cart"

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let inputData = Observable.merge(
            rx.methodInvoked(#selector(viewWillAppear(_:))).map { _ in }
        )
        shoppingCartTableView.delegate = nil
        shoppingCartTableView.dataSource = nil
        shoppingCartTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let output = viewModel.bind(CartInput(viewLoaded: inputData))
        output.cart.bind(to: shoppingCartTableView.rx.items(dataSource: dataSource())).disposed(by: disposeBag)
        output.cartTotal.bind(to: totalPriceLabel.rx.text).disposed(by: disposeBag)
        
    }
}

extension ShoppingCartViewController {
    
        private func dataSource() -> RxTableViewSectionedReloadDataSource<CartSection> {
            .init { datasource, tableView, indexPath, row in
                let cell: ShoppingCartTableViewCell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.reuseIdentifier(), for: indexPath) as! ShoppingCartTableViewCell
                
                cell.bind(viewModel: CartCellViewModel(row: row),
                          incrementObserver: self.viewModel.incrementProduct,
                          decrementObserver: self.viewModel.decrementProduct)
                return cell
            }
    }
}


extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
}
