//
//  String+isValidPhone.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 13/06/2022.
//

import Foundation

extension String {
    
    func isValidPhone() -> Bool {
            let regex = "^[0-9]{8}$"
            let phoneTest = NSPredicate(format:"SELF MATCHES %@", regex)
            return phoneTest.evaluate(with: self)
        }
}


