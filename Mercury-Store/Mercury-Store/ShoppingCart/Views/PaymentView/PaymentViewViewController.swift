//
//  PaymentViewViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 13/06/2022.
//

import UIKit
import RxSwift

class PaymentViewViewController: UIViewController {
    // MARK: - IBOutlets
    //
    @IBOutlet weak var selectPaymentTable: UITableView!
    @IBOutlet weak var validateCoupon: UIButton!
    @IBOutlet weak var couponInput: UITextField!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var discountValue: UILabel!
    @IBOutlet weak var shippingFees: UILabel!
    @IBOutlet weak var confirmOrder: UIButton!
    @IBOutlet weak var subTotal: UILabel!
    
    //MARK: - Properties
    //
    private let disposeBag = DisposeBag()
    private var viewModel: PaymentViewModelType!
    let connection = NetworkReachability.shared
    // MARK: - Set up
    //
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle? ,viewModel: PaymentViewModelType) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        initTable()
        readCoupon()
        totalFees()
        confirmAction()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        connection.checkNetwork(target: self)
    }
    
    private func setUpUI() {
        self.confirmOrder.tintColor = ColorsPalette.labelColors
        self.confirmOrder.configuration?.background.backgroundColor = ColorsPalette.lightColor
        self.validateCoupon.tintColor = ColorsPalette.labelColors
        self.validateCoupon.configuration?.background.backgroundColor = ColorsPalette.lightColor
        
        self.couponInput.isUserInteractionEnabled = false
        
       
    }
}
// MARK: - Extensions
extension PaymentViewViewController{
    // MARK: - Private handlers
    //
    func readCoupon(){
        viewModel.CouponInfo.asObservable().subscribe { item in
            guard let element = item.element else{ return }
            self.couponInput.text = element.title
            self.discountValue.text = element.value
        }.disposed(by: disposeBag)
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
        }.disposed(by: disposeBag)
    }
}
// MARK: - Extensions
extension PaymentViewViewController:UITableViewDelegate ,UITableViewDataSource{
    // MARK: - Private handlers
    //
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
        }.disposed(by: disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: false)
    }
    
}
