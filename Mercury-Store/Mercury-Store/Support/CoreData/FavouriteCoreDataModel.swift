//
//  FavouriteCoreDataModel.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 07/06/2022.
//

import Foundation
import CoreData
extension CoreDataModel{
    func deleteFavouriteProduct(productID:Int)->Bool{
        if(isBothProduct(id: productID)){
            var Product = getItemByID(productID: productID)
            Product.producrState = productStates.cart.rawValue
            return (update(updateitem: Product)).1
        }else{
            return delete(itemID: productID)
        }
    }
    func isProductFavourite (id :Int) -> Bool {
            var results: [NSManagedObject] = []
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entity)
        fetchRequest.predicate =  NSPredicate(format: "\(productCoredataAttr.id.rawValue) = %@ AND (\(productCoredataAttr.state.rawValue)  = %@ OR \(productCoredataAttr.state.rawValue) = %@)", argumentArray: [id as CVarArg, productStates.favourite.rawValue , productStates.both.rawValue])
            do {
                results = try managedObjectContext.fetch(fetchRequest)
            }
            catch {
                print("error executing fetch request: \(error)")
            }
            return results.count > 0
        }
    func insertFavouriteProduct(product:SavedProductItem)->Bool{
        if (isCartProduct(id: Int(truncating: NSDecimalNumber(decimal: product.productID)))) {
            var product = getItemByID(productID: Int(truncating: NSDecimalNumber(decimal: product.productID)))
            product.producrState = productStates.both.rawValue
            return update(updateitem: product).1
        }
        else if(!isProductExist(id: Int(truncating: NSDecimalNumber(decimal: product.productID)))){
            return insert(item: product).1
        }
        return false
    }
}
