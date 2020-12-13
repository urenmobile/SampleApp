//
//  BaseLocalRepository.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/12/20.
//

import Foundation
import CoreData

public class BaseLocalRepository<EntityType>: LocalRepositoryProvider where EntityType: NSManagedObject {

    public typealias Entity = EntityType
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func create() -> Entity {
        return Entity(context: context)
    }
    
    public func read(by predicate: NSPredicate) -> Entity? {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = predicate
        
        guard case .success(let entities) = fetch(fetchRequest) else {
            return nil
        }
        return entities.first
    }
    
    public func delete(_ entity: Entity) {
        context.delete(entity)
    }
    
    public func fetch(by predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[EntityType], Error> {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        return fetch(fetchRequest)
    }
    
    public func saveContext() -> Result<Bool, Error> {
        guard context.hasChanges else {
            return .success(true)
        }
        
        do {
            try self.context.save()
        } catch {
            let nserror = error as NSError
            debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            return .failure(CoreDataError.commitError)
        }
        return .success(true)
    }
    
    private func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) -> Result<[EntityType], Error> {
        do {
            guard let fetchedObjects = try context.fetch(request) as? [Entity] else {
                return .failure(CoreDataError.fetchError)
            }
            return .success(fetchedObjects)
        } catch {
            debugPrint("Fetch for type: \(Entity.self) - error: \(error)")
            return .failure(error)
        }
    }
}

// MARK: - CoreDataError
extension BaseLocalRepository {
    public enum CoreDataError: Error {
        case fetchError
        case commitError
    }
}
