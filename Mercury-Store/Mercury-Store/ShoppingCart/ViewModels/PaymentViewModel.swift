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
    func startCheckout()
}

class PaymentViewModel:PaymentViewModelType{
    
    
    private let couponSubject = BehaviorRelay<PriceRule>(value: PriceRule() )
    private let isLoadingSubject = BehaviorRelay<Bool>(value: false)
    private let errorSubject = BehaviorRelay<String?>(value: nil)
    private var braintreeClient: BTAPIClient?
    
    var CouponLoading: Driver<Bool>
    var CouponInfo: Driver<PriceRule>
    var CouponError: Driver<String?>
    
    let userDefaults:UserDefaults
    let couponApi:PricesRulesProvider = PricesRulesApi()
    let disposeBag = DisposeBag()
    
    init(_userDefaults:UserDefaults = UserDefaults() ) {
        userDefaults = _userDefaults
        CouponInfo = couponSubject.asDriver(onErrorJustReturn: PriceRule() )
        CouponLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)
        CouponError = errorSubject.asDriver(onErrorJustReturn: "Somthing went wrong")
        fetchCouponData()
    }
    
    func checkIfHasCoupon()->Int?{
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
                        self?.isLoadingSubject.accept(false)
                        self?.couponSubject.accept(result.priceRule)
                    } onError: {[weak self] (error) in
                        self?.isLoadingSubject.accept(false)
                        self?.errorSubject.accept(error.localizedDescription)
                    }.disposed(by: disposeBag)
    }
    
    func startCheckout() {
        self.braintreeClient = BTAPIClient(authorization: PaymentModel.braintreeAuthorization)!
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
        let request = BTPayPalCheckoutRequest(amount: "2.32")
        request.currencyCode = PaymentModel.currencyCode
        payPalDriver.tokenizePayPalAccount(with: request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                let email = tokenizedPayPalAccount.email
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
            } else if let error = error {
            } else {
            }
        }
    }
    
}
