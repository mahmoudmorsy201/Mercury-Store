//
//  CartState.swift
//  Mercury-Store
//
//  Created by mac hub on 01/06/2022.
//

import Foundation


struct CartState {
    
    private(set) var sections: [CartSection]
    init(_ sections: [CartSection]) {
        self.sections = sections
    }
    
    static func empty() -> CartState {
        CartState([CartSection([])])
    }
    
    func execute(_ action: CartAction) -> CartState {
        guard self.sections.count < 2 else { fatalError("CartState only supports 1 section") }
        switch action {
        case .viewIsLoaded:
            return CartState([CartSection(CartCoreDataManager.shared.getDataFromCoreData().map{CartRow(products: [$0])})])
        case .increment(let product):
            return CartState([increment(product, in: self.sections[0])])
        case .decrement(let product):
            return CartState([decrement(product, in: self.sections[0])])
        case .deleteItem(let product):
            return CartState([delete(product, in: self.sections[0])])
        case .proceedToCheckout:
            return .empty()
        }
    }
        
    private func increment(_ product: SavedProductItem, in section: CartSection) -> CartSection {
        if let row = section.row(for: product) {
            if row.products.count == 10 {
                return section
            }else {
                let products = row.products + [product]
                let newRow = CartRow(uuid: row.uuid, products: products)
                CartCoreDataManager.shared.updateExistingItem(with: SavedProductItem(productID: product.productID, productTitle: product.productTitle, productImage: product.productImage, productPrice: product.productPrice, productQTY: products.count, producrState: 1))
                return section.replacing(newRow)
            }
        } else {
            return section
        }
    }
    
    private func decrement(_ product: SavedProductItem, in section: CartSection) -> CartSection {
        if let row = section.row(for: product) {
            if row.products.count == 1 {
                return section
            } else {
                let products = Array(row.products.dropLast())
                CartCoreDataManager.shared.updateExistingItem(with: SavedProductItem(productID: product.productID, productTitle: product.productTitle, productImage: product.productImage, productPrice: product.productPrice, productQTY: products.count, producrState: 1))
                let newRow = CartRow(uuid: row.uuid, products: products)
                return section.replacing(newRow)
            }
        
        } else {
            return section
        }
    }
    
    private func delete(_ product: SavedProductItem, in section: CartSection) -> CartSection {
        if let row = section.row(for: product) {
            return section.removing(row)
        }
        return section
    }
}

fileprivate extension CartSection {
    
    func row(for product: SavedProductItem) -> CartRow? {
        return rows.filter { $0.products.contains(product)}.first
    }
    
    func replacing(_ row: CartRow) -> CartSection {
        if let index = rows.firstIndex(of: row) {
            var rows = self.rows
            rows[index] = row
            return CartSection(rows)
        } else {
            return self
        }
    }
    
    
    func removing(_ row: CartRow) -> CartSection {
        if let index = rows.firstIndex(of: row) {
            var rows = self.rows
            rows.remove(at: index)
            return CartSection(rows)
        } else {
            return self
        }
    }
}
