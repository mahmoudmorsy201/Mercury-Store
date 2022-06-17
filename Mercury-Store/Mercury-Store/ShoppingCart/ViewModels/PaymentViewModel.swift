//
//  PaymentViewModel.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 14/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Braintree

protocol PaymentViewModelType{
    var CouponLoading: Driver<Bool> { get }
    var CouponInfo: Driver<PriceRule> { get}
    var CouponError: Driver<String?> { get }
    var paymentMethod:paymentOptions { set get }
    var subTotal: Double{ get }
    var total: BehaviorSubject<Double>{ get }
    func confirmOrder()
}

class PaymentViewModel:PaymentViewModelType{
    var total: BehaviorSubject<Double>
    
    var subTotal: Double
    
    private let couponSubject = BehaviorRelay<PriceRule>(value: PriceRule() )
    private let isLoadingSubject = BehaviorRelay<Bool>(value: false)
    private let errorSubject = BehaviorRelay<String?>(value: nil)
    private var braintreeClient: BTAPIClient?
    private let ordersProvider: OrdersProvider
    
    var CouponLoading: Driver<Bool>
    var CouponInfo: Driver<PriceRule>
    var CouponError: Driver<String?>
    
    let userDefaults:UserDefaults
    let couponApi:PricesRulesProvider = PricesRulesApi()
    let disposeBag = DisposeBag()
    
    var paymentMethod: paymentOptions
    
    init(_userDefaults:UserDefaults = UserDefaults() ,paymentMethod:paymentOptions = .cashOnDelivery , ordersProvider: OrdersProvider = OrdersClient() ) {
        userDefaults = _userDefaults
        CouponInfo = couponSubject.asDriver(onErrorJustReturn: PriceRule() )
        CouponLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)
        CouponError = errorSubject.asDriver(onErrorJustReturn: "Somthing went wrong")
        self.ordersProvider = ordersProvider
        total = BehaviorSubject<Double>(value: 0)
        self.subTotal = 0
        self.paymentMethod = paymentMethod
        self.totalItemsPrice()
        fetchCouponData()
    }
    
    private func checkIfHasCoupon()->Int?{
        do{
            let couponId = try userDefaults.getObject(forKey: "discountId", castTo: Int.self)
            return couponId
        }catch (_){
            return nil
        }
    }
    
    func fetchCouponData(){
        guard let couponID = checkIfHasCoupon() else { return  }
        self.couponApi.getSinglePriceData(id: couponID)
            .observe(on: MainScheduler.asyncInstance)
                    .subscribe {[weak self] (result) in
                        guard let self = self else{ return }
                        self.isLoadingSubject.accept(false)
                        self.couponSubject.accept(result.priceRule)
                        self.handleCouponDiscount(discountValue: abs(Double(result.priceRule.value) ?? 0.0) )
                    } onError: {[weak self] (error) in
                        guard let self = self else{ return }
                        self.isLoadingSubject.accept(false)
                        self.errorSubject.accept(error.localizedDescription)
                    }.disposed(by: disposeBag)
    }
    
    func handleCouponDiscount(discountValue:Double){
        do{
            let temp = try total.value()
            if discountValue > temp{
                total.onNext(0)
            }else{
                total.onNext(temp - discountValue)
            }
        }catch(_){
        }
    }
    
    private func getUserFromUserDefaults() -> User? {
        do {
            return try userDefaults.getObject(forKey: "user", castTo: User.self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func startCheckout(amount:String) {
        self.braintreeClient = BTAPIClient(authorization: PaymentModel.braintreeAuthorization)!
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
        let request = BTPayPalCheckoutRequest(amount: amount)
        request.currencyCode = PaymentModel.currencyCode
        payPalDriver.tokenizePayPalAccount(with: request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                self.postOrder(financial_status: "paid")
            } else if let error = error {
                print(error)
            } else {
                print("the user canceled")
            }
        }
    }
    
    private func postOrder(financial_status:String = "authorized") {
        let user = getUserFromUserDefaults()
        let lineItems = getLineItems().map { LineItemDraft(quantity: $0.productQTY, variantID: $0.variantId)}
        let discountValue = couponSubject.value
        let order = try! OrderItem(lineItems: lineItems, customer: CustomerId(id: user!.id), useCustomerDefaultAddress: true, current_subtotal_price: "\(subTotal)", current_total_discounts: "\(discountValue)", total_price: "\(total.value())", financial_status: financial_status)
        if (user != nil) {
            let newOrderRequest = PostOrderRequest(order: order)
        self.ordersProvider.postOrder(order: newOrderRequest)
            .subscribe(onNext: {[weak self] result in
                guard let `self` = self else {fatalError()}
                print(result)
            }).disposed(by: disposeBag)
        }
    }
    
    private func getLineItems()->[SavedProductItem]{
        return CartCoreDataManager.shared.getDataFromCoreData()
    }
    
    private func totalItemsPrice(){
        var itemsPrice:Double = 0
        for item in getLineItems(){
            itemsPrice += item.productPrice*Double(item.productQTY)
        }
        subTotal = itemsPrice
        total.onNext(subTotal)
    }
    
    func confirmOrder(){
        switch(paymentMethod){
        case .withPaypal:
            do{
                let totalFees = try! total.value()
                self.startCheckout(amount: "\(totalFees)")
            }
        case .cashOnDelivery:
            self.postOrder()
        }
    }
    
}
