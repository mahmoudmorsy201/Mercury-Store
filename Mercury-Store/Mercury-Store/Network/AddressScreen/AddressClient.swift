//
//  AddressClient.swift
//  Mercury-Store
//
//  Created by mac hub on 13/06/2022.
//

import RxSwift

protocol AddressProvider: AnyObject {
    func postAddress(with customerId: Int , addressRequest: AddressRequest) -> Observable<AddressResponse>
    func getAddress(id:Int) -> Observable<RegisterResponse>
}

class AddressClient: AddressProvider {
    func postAddress(with customerId: Int, addressRequest: AddressRequest) -> Observable<AddressResponse> {
        NetworkService().execute(AddressAPI.postAddress(customerId, addressRequest))
    }
    func getAddress(id:Int) -> Observable<RegisterResponse>{
        NetworkService().execute(AddressAPI.getAddress(id))
    }
    
    
}


