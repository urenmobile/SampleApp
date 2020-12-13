//
//  ProductEntity+CoreDataProperties.swift
//  
//
//  Created by Remzi YILDIRIM on 12/13/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var createDate: Date?
    @NSManaged public var image: Data?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var productDescription: String?
    @NSManaged public var productId: String?

}
