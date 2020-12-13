//
//  ProductCoreData.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation
import CoreData
import URENCombine

class ProductCoreData: NSObject {
    
    var reloadableChangesSubject = PassthroughSubject<ReloadableChanges, Never>()
    
    private var insertItems: [IndexPath] = []
    private var deleteItems: [IndexPath] = []
    private var reloadItems: [IndexPath] = []
    private var moveItems: [(from: IndexPath, to: IndexPath)] = []

    private lazy var fetchedResultsController: NSFetchedResultsController<ProductEntity> = {
        let productIdSort = NSSortDescriptor(key: #keyPath(ProductEntity.createDate), ascending: true)
        let request: NSFetchRequest = ProductEntity.fetchRequest()
        request.sortDescriptors = [productIdSort]
        request.fetchBatchSize = 20
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: PersistentManager.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    private func insertItem(to indexPath: IndexPath) {
        insertItems.append(indexPath)
    }
    
    private func deleteItem(at indexPath: IndexPath) {
        deleteItems.append(indexPath)
    }
    
    private func reloadItem(at indexPath: IndexPath) {
        reloadItems.append(indexPath)
    }
    
    private func moveItem(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        moveItems.append((from: indexPath, newIndexPath))
    }
    
    private func performBatchUpdate() {
        let reloadableChanges = ReloadableChanges(insertItems: insertItems,
                                                  deleteItems: deleteItems,
                                                  reloadItems: reloadItems,
                                                  moveItems: moveItems)

        reloadableChangesSubject.send(reloadableChanges)
        insertItems.removeAll()
        deleteItems.removeAll()
        reloadItems.removeAll()
        moveItems.removeAll()
    }
}

extension ProductCoreData: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {
                return
            }
            
            insertItem(to: newIndexPath)
        case .delete:
            guard let indexPath = indexPath else {
                return
            }
            
            deleteItem(at: indexPath)
        case .update:
            guard let indexPath = indexPath else {
                return
            }
            
            reloadItem(at: indexPath)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {
                return
            }
            
            moveItem(at: indexPath, to: newIndexPath)
        @unknown default:
            debugPrint("Error")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        performBatchUpdate()
    }
}

// MARK: - ProductCoreDataProvider
extension ProductCoreData: ProductCoreDataProvider {
    
    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Failed fetch from core data")
        }
    }
    
    func numberOfSection() -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func willDisplayItem(at indexPath: IndexPath) {
        // TODO: write code for pagination
    }
    
    func item(at indexPath: IndexPath) -> ProductEntity {
        return fetchedResultsController.object(at: indexPath)
    }
}
