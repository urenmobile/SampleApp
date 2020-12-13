//
//  ProductLocal.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation
import URENDomain
import URENData

public class ProductLocal: ProductLocalProvider {
    
    private let persistent: PersistentProvider
    
    private var currentEntites: [ProductEntity] = []
    
    public init(persistent: PersistentProvider) {
        self.persistent = persistent
    }
    
    public func saveProducts(response: ProductResponse) {
        guard let products = response.products else {
            return
        }
        
        currentEntites = persistent.fetch()

        products.forEach { createOrUpdate(product: $0) }

        // Remove remaining currentEntites from core data
        currentEntites.forEach { persistent.delete($0) }

        // Commit
        persistent.saveContext()
    }
    
    public func saveProductDetail(response: ProductDetailResponse) {
        currentEntites = persistent.fetch()
        guard let matchedEntity = currentEntites.filter({ $0.productId == response.productId }).first else {
            return
        }
        matchedEntity.update(with: response)
    }
    
    
    private func createOrUpdate(product: ProductModel) {
        let matchedEntity = currentEntites.filter { $0.productId == product.productId }.first
        
        if let entity = matchedEntity {
            entity.update(with: product)
            // Remove entity from currentEntites local list
            if let index = currentEntites.firstIndex(of: entity) {
                currentEntites.remove(at: index)
            }
        } else {
            createEntity(with: product)
        }
    }
    
    private func createEntity(with product: ProductModel) {
        print("createEntity productId: \(product.productId ?? "")")
        let entity: ProductEntity = persistent.create()
        entity.createDate = Date()
        entity.update(with: product)
    }
}

extension ProductEntity: DomainModelConvertible {
    public func update(with model: ProductModel) {
        productId = model.productId
        name = model.name
        price = model.price ?? 0
        imageUrl = model.imageUrl
        productDescription = model.description
    }
    
    public func toDomain() -> ProductModel {
        return ProductModel(productId: productId,
                            name: name,
                            price: price,
                            imageUrl: imageUrl,
                            description: productDescription)
    }
}
