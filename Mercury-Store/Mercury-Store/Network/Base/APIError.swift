//
//  APIError.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

import Foundation

enum APIError: Error {
    case forbidden //Status code 403
    case notFound // Status code 404
    case conflict // Status code 409
    case internalServerError // Status code 500
    case parsingError
}

