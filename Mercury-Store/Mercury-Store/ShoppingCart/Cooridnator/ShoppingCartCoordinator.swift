//
//  ShoppingCartCoordinator.swift
//  Mercury-Store
//
//  Created by mac hub on 02/06/2022.
//

import UIKit

class ShoppingCartCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        let cartViewModel = CartViewModel(shoppingCartNavigationFlow: self)
        
        let cartVC = ShoppingCartViewController(with: cartViewModel)
        
        navigationController.pushViewController(cartVC, animated: true)
    }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
}

extension ShoppingCartCoordinator: ShoppingCartNavigationFlow {
    func goToAddAddressScreen() {
        let addressViewModel: AddressViewModelType = AddressViewModel(navigationFlow: self)
        let newAddressVC = CreateAddressDetailsViewController(with: addressViewModel)
        navigationController.present(newAddressVC, animated: true)
    }
    func goToPaymentScreen(){
        navigationController.dismiss(animated: true)
        let paymentAddressVC = PaymentViewViewController(nibName: "PaymentViewViewController", bundle: nil)
        navigationController.pushViewController(paymentAddressVC, animated: true)
    }
    
}
