//
//  DraftOrdersViewModels.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 10/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
protocol DraftOrdersViewModelsType{
    var isLoading: Driver<Bool> { get }
    var error: Driver<String?> { get }
    var userID:Int{ get}
    var orders: Driver<[OrderItem]>{get}
}
class DraftOrdersViewModels:DraftOrdersViewModelsType{
    let ordersProvider :OrdersProvider
    let disposeBag = DisposeBag()
    var isLoading: Driver<Bool>
    
    var error: Driver<String?>
    
    var userID: Int  {
        MyUserDefaults.shared.getValue(forKey: .id) as! Int
    }
    private let typesSubject = BehaviorRelay<[OrderItem]>(value: [])
    private let isLoadingSubject = BehaviorRelay<Bool>(value: false)
    private let errorSubject = BehaviorRelay<String?>(value: nil)
    
    var orders: Driver<[OrderItem]>
    init() {
        orders = typesSubject.asDriver(onErrorJustReturn: [])
        isLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)
        error = errorSubject.asDriver(onErrorJustReturn: "Something went wrong")
        ordersProvider = OrderListApi()
        fetchOrders()
    }
    private func fetchOrders(){
        self.typesSubject.accept([])
        self.isLoadingSubject.accept(true)
        self.errorSubject.accept(nil)
        self.ordersProvider.getOrderList()
            .observe(on: MainScheduler.asyncInstance)
                    .subscribe {[weak self] (result) in
                        guard let self = self else{return}
                        self.isLoadingSubject.accept(false)
                        self.typesSubject.accept(result.orders)
                    } onError: {[weak self] (error) in
                        self?.isLoadingSubject.accept(false)
                        self?.errorSubject.accept(error.localizedDescription)
                    }.disposed(by: disposeBag)
    }
}
