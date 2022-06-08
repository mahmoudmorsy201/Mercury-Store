//
//  CustomerClient.swift
//  Mercury-Store
//
//  Created by mac hub on 08/06/2022.
//

import RxSwift

protocol CustomerProvider: AnyObject {
    func postCustomer(_ customer: Customer) -> Observable<Customer>
}

class CustomerClient: CustomerProvider {
    func postCustomer(_ customer: Customer) -> Observable<Customer> {
        NetworkService().execute(CustomerAPI.postCustomer(customer))
    }
    
    
}
