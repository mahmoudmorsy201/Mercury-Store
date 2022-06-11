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
    func postOrder(order:OrderRequest) -> Observable<OrderItemPostResponse>
}

class OrderListApi: OrdersProvider {
    func postOrder(order: OrderRequest)  -> Observable<OrderItemPostResponse>{
        NetworkService().execute(OrdersAPI.postOrder(order))
    }
    
    func getOrderList() -> Observable<OrderList> {
        NetworkService().execute(OrdersAPI.getOrders)
    }
    
}
