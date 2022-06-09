//
//  ErrorResponse.swift
//  Mercury-Store
//
//  Created by mac hub on 09/06/2022.
//

import Foundation

enum CustomerErrors: String {
    case emailExists = "Email already registered please login"
    case emailNotExists = "Please register first"
}
