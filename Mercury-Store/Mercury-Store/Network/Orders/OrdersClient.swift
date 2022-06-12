//
//  OrdersClient.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 10/06/2022.
//

import Foundation
import RxSwift

protocol OrdersProvider: AnyObject {
    //func getOrderList(with customerId: Int) -> Observable<OrderList>
    func postOrder(order: DraftOrdersRequest) -> Observable<DraftOrderResponseTest>
    func modifyExistingOrder(with oderId: Int, and putOrderRequest: PutOrderRequest) -> Observable<DraftOrderResponseTest>
}

class OrdersClient: OrdersProvider {
    func modifyExistingOrder(with oderId: Int, and putOrderRequest: PutOrderRequest) -> Observable<DraftOrderResponseTest> {
        NetworkService().execute(OrdersAPI.modifyExistingOrder(oderId, putOrderRequest))
    }
    
    func postOrder(order: DraftOrdersRequest)  -> Observable<DraftOrderResponseTest>{
        NetworkService().execute(OrdersAPI.postOrder(order))
    }
    
//    func getOrderList(with customerId: Int) -> Observable<OrderList> {
//        NetworkService().execute(OrdersAPI.getOrders(customerId))
//    }
    
}
