//
//  ShoppingCartViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit

class ShoppingCartViewController: UIViewController, ShoppingCartCoordinated {
    
    @IBOutlet weak private var totalPriceLabel: UILabel!
    
    
    @IBOutlet weak private var shoppingCartTableView: UITableView! {
        didSet {
            shoppingCartTableView.register(UINib(nibName: ShoppingCartTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: ShoppingCartTableViewCell.reuseIdentifier())
        }
    }
    
    
    @IBOutlet weak private var proceedToCheckoutBtn: UIButton!
    
    var coordinator: ShoppingCartBaseCoordinator?
    
    
    init(coordinator: ShoppingCartBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        
        self.coordinator = coordinator
        title = "Cart"

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

extension ShoppingCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.reuseIdentifier(), for: indexPath) as? ShoppingCartTableViewCell else {fatalError("Couldn't dequeue the cell")}
//        cell.shoppingItem = viewModel.
        return cell
    }
    
    
}

extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



