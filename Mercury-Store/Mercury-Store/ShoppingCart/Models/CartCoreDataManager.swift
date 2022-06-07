//
//  CartCoreDataManager.swift
//  Mercury-Store
//
//  Created by mac hub on 01/06/2022.
//

import Foundation

class CartCoreDataManager {
    static let shared = CartCoreDataManager()
    private let coreDataModel:CoreDataModel
    
    private init(coreDataModel:CoreDataModel = CoreDataModel.coreDataInstatnce) {
        self.coreDataModel = coreDataModel
    }
    
    func getDataFromCoreData() -> [SavedProductItem] {
        let items = self.coreDataModel.getItems(productState: productStates.cart)
        if(items.1 == nil) {
            
            return items.0
        }else {
            print(items.1?.localizedDescription)
        }
        return items.0
    }
    
    func saveNewCartItem(with item: SavedProductItem) {
        coreDataModel.insert(item: item)
    }
    
    func updateExistingItem(with item: SavedProductItem) {
        coreDataModel.update(updateitem: item)
    }
    
    func deleteItem(with item: SavedProductItem) {
        //mahmoud
        //coreDataModel.delete(updateitem: item)
        coreDataModel.deleteCartItem(productID: Int(truncating: NSDecimalNumber(decimal: item.productID)) )
    }
}

