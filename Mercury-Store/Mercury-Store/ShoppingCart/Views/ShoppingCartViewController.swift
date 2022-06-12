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

class ShoppingCartViewController: UIViewController {
    
    @IBOutlet weak private var totalPriceLabel: UILabel!
    @IBOutlet weak var checkoutBTN: UIButton!
    
    @IBOutlet weak private var shoppingCartTableView: UITableView! {
        didSet {
            shoppingCartTableView.register(UINib(nibName: ShoppingCartTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: ShoppingCartTableViewCell.reuseIdentifier())
        }
    }
  
    private var viewModel: CartViewModel?
    private let disposeBag = DisposeBag()
    
    init(with viewModel: CartViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel?.viewDidDisappear()
    }
    
    private func bind() {
        guard let viewModel = self.viewModel else {fatalError("Couldn't unwrap viewModel")}
        
        let inputData = Observable.merge(
            rx.methodInvoked(#selector(viewWillAppear(_:))).map { _ in }
        )
        shoppingCartTableView.delegate = nil
        shoppingCartTableView.dataSource = nil
        shoppingCartTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let output = viewModel.bind(CartInput(viewLoaded: inputData))
        
        output.cart.bind(to: shoppingCartTableView.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)

        output.cartBadge.subscribe { value in
            if(value == "0") {
                self.navigationController?.tabBarItem.badgeValue = nil
            }else {
                self.navigationController?.tabBarItem.badgeValue = value
            }
            
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)

        output.cartEmpty.bind(to: shoppingCartTableView.rx.isEmpty(message: "Your cart is empty"))
            .disposed(by: disposeBag)
        
        output.cartTotal.bind(to: totalPriceLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

//MARK: Private handlers

extension ShoppingCartViewController {
    
    private func dataSource() -> RxTableViewSectionedReloadDataSource<CartSection> {
        .init {[weak self] datasource, tableView, indexPath, row in
            let cell: ShoppingCartTableViewCell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.reuseIdentifier(), for: indexPath) as! ShoppingCartTableViewCell
            guard let `self` = self else {fatalError()}
            guard let viewModel = self.viewModel else {fatalError("Couldn't unwrap viewModel")}
            cell.bind(viewModel: CartCellViewModel(row: row),
                      incrementObserver: viewModel.incrementProduct,
                      decrementObserver: viewModel.decrementProduct,
                      deleteObserver: viewModel.deleteProduct)
           
            return cell
        }
    }
}

//MARK: Delegates

extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
}
