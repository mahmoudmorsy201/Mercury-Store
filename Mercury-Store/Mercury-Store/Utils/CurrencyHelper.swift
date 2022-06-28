//
//  CurrencyHelper.swift
//  Mercury-Store
//
//  Created by mac hub on 28/06/2022.
//

import Foundation

extension String {
    func toCurrencyFormatEGP() -> String {
        if let intValue = Double(self){
            let value = intValue * 18.76
            return "EGP \(value)"
        }
        return ""
    }
    func toCurrencyFormatUSD() -> String {
        if let intValue = Double(self){
            return "USD \(intValue)"
        }
        return ""
    }
}
