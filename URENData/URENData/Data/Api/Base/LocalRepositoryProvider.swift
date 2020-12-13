//
//  LocalRepositoryProvider.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/12/20.
//

import Foundation

public protocol LocalRepositoryProvider {
    associatedtype Entity
    
    func create() -> Entity
    func read(by predicate: NSPredicate) -> Entity?
    func delete(_ entity: Entity)
    func fetch(by predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error>
    func fetchAll() -> Result<[Entity], Error>
    func deleteAll() -> Result<Bool, Error>
    func saveContext() -> Result<Bool, Error>
}

extension LocalRepositoryProvider {
    public func fetchAll() -> Result<[Entity], Error> {
        fetch(by: nil, sortDescriptors: nil)
    }
}

extension LocalRepositoryProvider where Self: AnyObject {
    @discardableResult
    public func deleteAll() -> Result<Bool, Error> {
        switch fetchAll() {
        case .success(let entities):
            entities.forEach { delete($0) }
            return .success(true)
        case .failure(let error):
            return .failure(error)
        }
    }
}
