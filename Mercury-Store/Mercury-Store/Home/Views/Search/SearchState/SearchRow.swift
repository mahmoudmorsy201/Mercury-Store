//
//  SearchRow.swift
//  Mercury-Store
//
//  Created by mac hub on 07/06/2022.
//

import Foundation


struct SearchRow {
    let uuid: UUID
    var products: [Product]
}

extension SearchRow {
    init(products: [Product]) {
        self.uuid = UUID()
        self.products = products
    }
    
}

extension SearchRow : Equatable {
    var identity: UUID {
        return uuid
    }
}

func ==(lhs: SearchRow, rhs: SearchRow) -> Bool {
    return lhs.uuid == rhs.uuid
}
