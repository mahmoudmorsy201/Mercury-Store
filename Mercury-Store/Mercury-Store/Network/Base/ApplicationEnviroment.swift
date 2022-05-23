//
//  ApplicationEnviroment.swift
//  Mercury-Store
//
//  Created by mac hub on 23/05/2022.
//

import Foundation

enum ApplicationEnviroment {
    case development
}

extension ApplicationEnviroment {
    static var currentState: ApplicationEnviroment {
        return .development
    }
}

extension ApplicationEnviroment {
    static var baseURL: URL {
        switch ApplicationEnviroment.currentState {
        case .development:
            return URL(string: Servers.development)!
        }
    }
}

extension ApplicationEnviroment {
    static var showLog: Bool {
        switch ApplicationEnviroment.currentState {
        case .development:
            return true
        }
    }
}

