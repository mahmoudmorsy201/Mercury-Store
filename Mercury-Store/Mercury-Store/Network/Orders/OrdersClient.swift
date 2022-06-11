//
//  OrdersClient.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 10/06/2022.
//

import Foundation
import RxSwift

protocol OrdersProvider: AnyObject {
    func getOrderList() -> Observable<OrderList>
}

class OrderListApi: OrdersProvider {
    func getOrderList() -> Observable<OrderList> {
        NetworkService().execute(OrdersAPI.getOrders)
    }
    
}
