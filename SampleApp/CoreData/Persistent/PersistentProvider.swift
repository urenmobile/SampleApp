//
//  PersistentProvider.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation
import CoreData

public protocol PersistentProvider {
    func create<T>() -> T where T: NSManagedObject
    func delete(_ object: NSManagedObject)
    func deleteAll<T>(_ type: T.Type) where T: NSManagedObject
    func fetch<T>() -> [T] where T: NSManagedObject
    func saveContext()
}
