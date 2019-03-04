//
//  Service.swift
//  IOSSolidPrinciplesSample
//
//  Created by Carlos Leonardo Camilo Vargas Huamán on 3/3/19.
//  Copyright © 2019 Carlos Leonardo Camilo Vargas Huamán. All rights reserved.
//

import Foundation
import CoreData

class Service {
    
    var managedContext : NSManagedObjectContext? = nil
    
    /*init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }*/
    
    init(appDelegate: AppDelegate) {
        initDatabase(appDelegate1: appDelegate)
    }
    
    func calculateProductTax(product: Product?) -> Double{
        if(product == nil) { return 0.0 }
        let tax = 0.19
        return product!.price * tax
    }
    
    func saveProduct(product: Product?) -> Bool {
        
        //Business logic - validate product
        if(product == nil || product!.id < 0 || product!.name.isEmpty){
            return false
        }
        
        //Insert in Database
        let entity = NSEntityDescription.entity(forEntityName: "ProductEntity",
                                                in: managedContext!)!
        let productEntity = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        productEntity.setValue(product!.id, forKeyPath: "id")
        productEntity.setValue(product!.name, forKeyPath: "name")
        productEntity.setValue(product!.price, forKeyPath: "price")
        
        return true
    }
    
    func getListProducts() -> Array<NSManagedObject> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductEntity")
        do {
            let productNSManagedObject = try managedContext!.fetch(fetchRequest)
            return productNSManagedObject
        } catch let error as NSError {
            print("Could not fetch. \(error),  \(error.userInfo)")
            return []
        }
    }
    

    func initDatabase(appDelegate1: AppDelegate) {
        managedContext = appDelegate1.persistentContainer.viewContext
    }
}
