//
//  OrdersClient.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 10/06/2022.
//

import Foundation
import RxSwift

protocol OrdersProvider: AnyObject {
    func getOrderList(userId:Int) -> Observable<DraftOrderList>
}

class OrderListApi: OrdersProvider {
    func getOrderList(userId: Int) -> Observable<DraftOrderList> {
        NetworkService().execute(OrdersAPI.getOrders(userId))
    }
    
}
