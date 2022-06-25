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
        if isProductExist(id: productID){
            var state = 0
            var item = getItemByID(productID: productID)
            if item.producrState == productStates.both.rawValue {
                item.producrState = productStates.cart.rawValue
                state = 1
            }
            if !item.user_id.contains(getCurrentUserId()!) && item.user_id.count > 1{
                item.user_id = item.user_id.filter{$0 != getCurrentUserId()!}
                state = 2
            }
            if state == 0{
                return delete(itemID: productID)
            }
            else{
                return update(updateitem: item).1
            }
        }
        return false
    }
    func toggleFavourite(product:SavedProductItem)->Bool{
        let isFavorite = isProductFavourite(id: Int(truncating: NSDecimalNumber(decimal: product.productID) ))
        if isFavorite {
            deleteFavouriteProduct(productID: Int(truncating: NSDecimalNumber(decimal: product.productID) ))
        }else{
            insertFavouriteProduct(product: product)
        }
        return !isFavorite
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
        return !results.isEmpty
        }
    
    func insertFavouriteProduct(product:SavedProductItem)->Bool{
        if isProductExist(id: Int(truncating: NSDecimalNumber(decimal: product.productID))){
            var item = getItemByID(productID: Int(truncating: NSDecimalNumber(decimal: product.productID)))
            if item.producrState == productStates.cart.rawValue {
                item.producrState = productStates.both.rawValue
            }
            if !item.user_id.contains(getCurrentUserId()!){
                item.user_id.append(getCurrentUserId()!)
            }
            return insert(item: item).1
        }
        else{
            return insert(item: product).1
        }
    }
    
    func getCurrentUserId()->Int?{
        let sharedInstance: UserDefaults = UserDefaults.standard
        do{
            let user:User = try sharedInstance.getObject(forKey: "user", castTo: User.self)
            return user.id
        }catch( _){
            return nil
        }
    }
}
