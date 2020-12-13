//
//  PersistentManager.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/5/20.
//

import Foundation
import CoreData

class PersistentManager {
    
    static let shared = PersistentManager()
    
    // MARK: - Core Data stack
    lazy var context = persistentContainer.viewContext

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SampleApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension PersistentManager: PersistentProvider {
    // MARK: - Core Data Create
    func create<T: NSManagedObject>() -> T {
        return T(context: context)
    }
    
    // MARK: Core Data Delete object
    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    // MARK: Core Data Delete All
    func deleteAll<T>(_ type: T.Type) where T: NSManagedObject {
        let items: [T] = fetch()
        items.forEach { delete($0) }
    }
    
    // MARK: - Core Data Fetch
    func fetch<T>() -> [T] where T: NSManagedObject {
        do {
            if let fetchedObjects = try context.fetch(T.fetchRequest()) as? [T] {
                return fetchedObjects
            }
        } catch {
            debugPrint("Fetch for type: \(T.self) - error: \(error)")
        }
        return [T]()
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if context.hasChanges {
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
}
