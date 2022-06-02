//
//  Collection+Safe.swift
//  Mercury-Store
//
//  Created by mac hub on 01/06/2022.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
