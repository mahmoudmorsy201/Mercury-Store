//
//  PaymentViewViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 13/06/2022.
//

import UIKit

class PaymentViewViewController: UIViewController {

    @IBOutlet weak var selectPaymentTable: UITableView!
    @IBOutlet weak var validateCoupon: UIButton!
    @IBOutlet weak var couponInput: UITextField!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var discountValue: UILabel!
    @IBOutlet weak var shippingFees: UILabel!
    @IBOutlet weak var subTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
    }

}

extension PaymentViewViewController:UITableViewDelegate ,UITableViewDataSource{
    
    private func initTable(){
        selectPaymentTable.register(UINib(nibName: "RadioButtonCell", bundle: nil), forCellReuseIdentifier: RadioButtonCell.reuseIdentifier())
        selectPaymentTable.delegate = self
        selectPaymentTable.dataSource = self
        selectPaymentTable.tableFooterView = UIView(frame: .zero)
        selectPaymentTable.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Payment Options"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectPaymentTable.dequeueReusableCell(withIdentifier: RadioButtonCell.reuseIdentifier()) as! RadioButtonCell
        return cell
    }
    
    
}
