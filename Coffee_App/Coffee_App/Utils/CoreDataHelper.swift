//
//  CoreDataHelper.swift
//  Coffee_App
//
//  Created by user219614 on 5/15/22.
//

import Foundation
import CoreData
import UIKit

// Manage Core Data eneities.
class CoreDataHelper {
    // Singleton
    static let shared: CoreDataHelper = CoreDataHelper()
    private init() {}
    
    var persistentContainer: NSPersistentContainer?
    
    func getContext() -> NSManagedObjectContext {
        return (persistentContainer?.viewContext)!
    }
    
    func saveContext() {
        if let context = persistentContainer?.viewContext, context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    @discardableResult
    func addMenu(model: CoffeeModel) -> CoffeeMenu {
        let entity = CoffeeMenu(context: self.getContext())
        entity.uuid = UUID()
        entity.image = model.image
        entity.price = model.price
        entity.name = model.name
        self.saveContext()
        return entity
    }
    
    func getAllMenus() -> [CoffeeMenu] {
        let request = CoffeeMenu.fetchRequest()
        let menus = try? self.getContext().fetch(request)
        
        return menus ?? []
    }
    
    func delete(menu: CoffeeMenu) {
        self.getContext().delete(menu)
        self.saveContext()
    }
}
