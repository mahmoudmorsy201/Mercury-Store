//
//  PaymentViewViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 13/06/2022.
//

import UIKit
import RxSwift

class PaymentViewViewController: UIViewController {
    let disposeBag:DisposeBag = DisposeBag()
    private var viewModel:PaymentViewModelType!
    @IBOutlet weak var selectPaymentTable: UITableView!
    @IBOutlet weak var validateCoupon: UIButton!
    @IBOutlet weak var couponInput: UITextField!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var discountValue: UILabel!
    @IBOutlet weak var shippingFees: UILabel!
    @IBOutlet weak var confirmOrder: UIButton!
    @IBOutlet weak var subTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
        readCoupon()
        totalFees()
        confirmAction()
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle? , subCartFeees:Double) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewModel = PaymentViewModel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension PaymentViewViewController{
    
    func readCoupon(){
        viewModel.CouponInfo.asObservable().subscribe { item in
            guard let element = item.element else{ return }
            self.couponInput.text = element.title
            self.discountValue.text = element.value
        }
    }
    
    func confirmAction(){
        confirmOrder.rx.tap.bind{
            self.viewModel.confirmOrder()
        }.disposed(by: disposeBag)
    }
    
    func totalFees(){
        subTotal.text = "\(viewModel.subTotal) USD"
        shippingFees.text = "0 USD"
        viewModel.total.asObserver().subscribe{ item in
            self.totalMoney.text = "\(item.element!) USD"
        }
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
        cell.paymentSubject.subscribe{ event in
            self.viewModel.paymentMethod = event.element!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: false)
    }
    
}