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
//            shoppingCartTableView.delegate = self
//            shoppingCartTableView.dataSource = self
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
        //bindTableView()
        let output = viewModel.bind()
        output.cart.bind(to: shoppingCartTableView.rx.items(dataSource: dataSource())).disposed(by: disposeBag)
        output.cartTotal.bind(to: totalPriceLabel.rx.text).disposed(by: disposeBag)
        
        
    }
//    private func bindTableView() {
//        shoppingCartTableView.delegate = nil
//        shoppingCartTableView.dataSource = nil
//        shoppingCartTableView.rx.setDelegate(self).disposed(by: disposeBag)
//        viewModel.cartProducts.drive(shoppingCartTableView.rx.items(cellIdentifier: ShoppingCartTableViewCell.reuseIdentifier(), cellType: ShoppingCartTableViewCell.self)) { index, row, cell in
//            
//            cell.bind(viewModel: CartCellViewModel(row: row), incrementObserver: self.viewModel.incrementProduct, decrementObserver: self.viewModel.decrementProduct)
//        }.disposed(by: disposeBag)
//        viewModel.fetchDataFromCoreData()
//    }
}

extension ShoppingCartViewController {
 
        private func dataSource() -> RxTableViewSectionedAnimatedDataSource<CartSection> {
            let animationConfiguration = AnimationConfiguration(insertAnimation: .left, reloadAnimation: .fade, deleteAnimation: .right)
            return RxTableViewSectionedAnimatedDataSource(animationConfiguration: animationConfiguration,
                                                          
              decideViewTransition: { _, _, changeset in
                changeset.isEmpty ? .reload : .animated
              },

              configureCell: { _, tableView, indexPath, row in
                let cell: ShoppingCartTableViewCell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.reuseIdentifier(), for: indexPath) as! ShoppingCartTableViewCell
                
                cell.bind(viewModel: CartCellViewModel(row: row),
                          incrementObserver: self.viewModel.incrementProduct,
                          decrementObserver: self.viewModel.decrementProduct)
                return cell
              },
                  
              canEditRowAtIndexPath: { _, _ in
                false
              })
        }
    }

//extension ShoppingCartViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.reuseIdentifier(), for: indexPath) as? ShoppingCartTableViewCell else {fatalError("Couldn't dequeue the cell")}
//
//        return cell
//    }
//
//
//}

extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
