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
    let managedObjectContext:NSManagedObjectContext
    let entity:String = "ProductsCoreData"
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
            let fetchedItems = try self.managedObjectContext.fetch(fetchRequest) as! [NSManagedObjectContext]
            if fetchedItems.count != 0{

                let managedObject = fetchedItems[0]
                managedObject.setValue(updateitem.productTitle, forKey: productCoredataAttr.title.rawValue)
                managedObject.setValue(updateitem.productImage, forKey: productCoredataAttr.image.rawValue)
                managedObject.setValue(updateitem.productPrice, forKey: productCoredataAttr.price.rawValue)
                managedObject.setValue(updateitem.productQTY, forKey: productCoredataAttr.quantity.rawValue)
                managedObject.setValue(updateitem.producrState, forKey: productCoredataAttr.state.rawValue)
                try self.managedObjectContext.save()
                return (updateitem, true)
            }
        } catch _ as NSError {
              return (SavedProductItem(), false)
          }
        return (updateitem , true)
    }
    func delete(itemID:Int) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entity)
        fetchRequest.predicate = NSPredicate(format: "(\(productCoredataAttr.id.rawValue) = %@)", itemID as CVarArg )
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
    
}
extension CoreDataModel{
    func isBothProduct(id :Int) -> Bool{
        var results: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entity)
    fetchRequest.predicate =  NSPredicate(format: "\(productCoredataAttr.id.rawValue) = %@ AND (\(productCoredataAttr.state.rawValue)  = %@ )", argumentArray: [id as CVarArg, productStates.both.rawValue])
        do {
            results = try managedObjectContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
    }
    func isProductExist(id :Int)->Bool{
        var results: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entity)
        fetchRequest.predicate =  NSPredicate(format: "\(productCoredataAttr.id.rawValue) = %@", argumentArray: [id as CVarArg])
        do {
            results = try managedObjectContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
    }
    func getItemByID(productID:Int)->SavedProductItem{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        fetchRequest.predicate =  NSPredicate(format: "\(productCoredataAttr.id.rawValue) = %@", argumentArray: [productID])
        
        do {
            let fetchedItems = try managedObjectContext.fetch(fetchRequest)[0]
            let itemMO = SavedProductItem(productID: fetchedItems.value(forKey: productCoredataAttr.id.rawValue) as! Decimal,
                                          productTitle: fetchedItems.value(forKey: productCoredataAttr.title.rawValue) as! String,
                                          productImage: fetchedItems.value(forKey: productCoredataAttr.image.rawValue) as! String,
                                          productPrice: fetchedItems.value(forKey: productCoredataAttr.price.rawValue) as! Double,
                                          productQTY: fetchedItems.value(forKey: productCoredataAttr.quantity.rawValue) as! Int,
                                          producrState: fetchedItems.value(forKey: productCoredataAttr.state.rawValue) as! Int)
            return itemMO
            }
        catch let error as NSError {
            print("Could not fetch. \(error)")
              return(SavedProductItem())
          }
    }
}
extension CoreDataModel: StorageOutputs {
    var items: Observable<SavedProductItem?> {
        return itemsPrivate.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
    var inputs: StorageInputs { return self }
    
    var outputs: StorageOutputs { return self }
}

