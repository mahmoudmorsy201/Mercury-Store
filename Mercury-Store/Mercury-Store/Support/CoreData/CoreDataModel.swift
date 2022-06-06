//
//  CoreDataModel.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 03/06/2022.
//

import Foundation
import CoreData
import RxSwift
import UIKit
//MARK: StorageProtocol
enum productStates :Int{
    case favourite = 0
    case cart = 1
    case both = 2
}
enum productCoredataAttr:String{
    case id = "id"
    case title = "title"
    case image = "image"
    case price = "price"
    case quantity = "quantity"
    case state = "state"
}
final class CoreDataModel: StorageProtocol {
    fileprivate  var itemsPrivate: PublishSubject<SavedProductItem?>
    static let coreDataInstatnce = CoreDataModel()
    fileprivate let managedObjectContext:NSManagedObjectContext
    fileprivate let entity:String = "ProductsCoreData"
    private  init(){
        managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        itemsPrivate = PublishSubject()
    }
    
}
//MARK: StorageInputs
extension CoreDataModel: StorageInputs {
    
    func getItems(productState:productStates ) -> ([SavedProductItem], Error?) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)

        fetchRequest.predicate =  NSPredicate(format: "\(productCoredataAttr.state.rawValue) = %@ OR \(productCoredataAttr.state.rawValue)  = %@", argumentArray: [productState.rawValue, 2])
        var resultItems = [SavedProductItem]()
        do {
            let fetchedItems = try managedObjectContext.fetch(fetchRequest)
            
            for itemMO in fetchedItems {
                let tmpItem: SavedProductItem = SavedProductItem(
                    productID: itemMO.value(forKey: productCoredataAttr.id.rawValue) as! Decimal,
                    productTitle: itemMO.value(forKey: productCoredataAttr.title.rawValue) as! String,
                    productImage: itemMO.value(forKey: productCoredataAttr.image.rawValue) as! String ,
                    productPrice: itemMO.value(forKey: productCoredataAttr.price.rawValue) as! Double,
                    productQTY: itemMO.value(forKey: productCoredataAttr.quantity.rawValue) as! Int,
                    producrState: itemMO.value(forKey: productCoredataAttr.state.rawValue) as! Int)
                resultItems.append(tmpItem)
            }
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
              return(resultItems , error)
          }
        return (resultItems, nil)
    }
    
    func insert(item : SavedProductItem) -> (SavedProductItem, Bool) {
        let entityItem = NSEntityDescription.entity(forEntityName: self.entity, in: self.managedObjectContext)!
        let product = NSManagedObject(entity: entityItem, insertInto: self.managedObjectContext)
        product.setValue(item.productID , forKey: productCoredataAttr.id.rawValue)
        product.setValue(item.productTitle , forKey: productCoredataAttr.title.rawValue)
        product.setValue(item.productImage , forKey:  productCoredataAttr.image.rawValue)
        product.setValue(item.productPrice , forKey: productCoredataAttr.price.rawValue)
        product.setValue(item.productQTY , forKey: productCoredataAttr.quantity.rawValue)
        product.setValue(item.producrState , forKey: productCoredataAttr.state.rawValue)
        do{
            try managedObjectContext.save()
        }catch _ as NSError {
            return (item, false)
        }
        return (item , true)
    }
    
    func update(updateitem:SavedProductItem) -> (SavedProductItem, Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entity)
        fetchRequest.predicate = NSPredicate(format: "(\(productCoredataAttr.id.rawValue) = %@)", updateitem.productID as CVarArg )
        do {
            let fetchedItems = try self.managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            if !fetchedItems.isEmpty {
                let product = fetchedItems.first
                product?.setValue(updateitem.productTitle, forKey: productCoredataAttr.title.rawValue)
                product?.setValue(updateitem.productImage, forKey: productCoredataAttr.image.rawValue)
                product?.setValue(updateitem.productPrice, forKey: productCoredataAttr.price.rawValue)
                product?.setValue(updateitem.productQTY, forKey: productCoredataAttr.quantity.rawValue)
                product?.setValue(updateitem.producrState, forKey: productCoredataAttr.state.rawValue)
                try self.managedObjectContext.save()
                return (updateitem, true)
            }
        } catch _ as NSError {
              return (SavedProductItem(), false)
          }
        return (updateitem , true)
    }
    func delete(updateitem:SavedProductItem) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entity)
        fetchRequest.predicate = NSPredicate(format: "(\(productCoredataAttr.id.rawValue) = %@)", updateitem.productID as CVarArg )
        do {
            let fetchedItems = try self.managedObjectContext.fetch(fetchRequest)
            for object in fetchedItems {
                self.managedObjectContext.delete(object as! NSManagedObject)
                }
            try self.managedObjectContext.save()
            return true
        } catch _ as NSError {
              return false
          }
    }
    func isProductFavourite (id :Int) -> Bool {
            var results: [NSManagedObject] = []
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entity)
        fetchRequest.predicate =  NSPredicate(format: "\(id) = %@ AND (\(productCoredataAttr.state.rawValue)  = %@ OR \(productCoredataAttr.state.rawValue) = %@)", argumentArray: [id as CVarArg, productStates.favourite.rawValue , productStates.both.rawValue])
        
//            let predicate = NSPredicate(format: "(\(productCoredataAttr.id.rawValue) = %@)", id as CVarArg )
            
        //    fetchRequest.predicate = predicate
            
            do {
                results = try managedObjectContext.fetch(fetchRequest)
            }
            catch {
                print("error executing fetch request: \(error)")
            }
            return results.count > 0
        }
}
extension CoreDataModel{
    
}
extension CoreDataModel: StorageOutputs {
    var items: Observable<SavedProductItem?> {
        return itemsPrivate.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
    var inputs: StorageInputs { return self }
    
    var outputs: StorageOutputs { return self }
}

