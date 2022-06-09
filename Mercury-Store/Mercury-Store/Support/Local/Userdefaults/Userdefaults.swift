//
//  Userdefaults.swift
//  Mercury-Store
//
//  Created by mac hub on 09/06/2022.
//

import Foundation


enum Keys: String {
    case email = "email"
    case username = "username"
    case loggedIn = "loggedIn"
    case id = "id"
    case isDiscount = "discount"
    case discountCode = "DiscountCode"
    case password = "password"
}

class MyUserDefaults {
    public static var shared = MyUserDefaults()
    
    private let sharedUserDefaults = UserDefaults.standard
    
    private init(){
        
    }
    public func add<T>(val : T,key : Keys){
        sharedUserDefaults.setValue(val, forKey: key.rawValue)
    }
    
    public func getValue(forKey key: Keys) -> Any?{
        return sharedUserDefaults.value(forKey: key.rawValue) ?? nil
    }
}
