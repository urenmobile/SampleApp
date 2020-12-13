//
//  ProductModel.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/1/20.
//

import Foundation

public class ProductModel: Model {
    public let productId: String?
    public let name: String?
    public let price: Double?
    public let imageUrl: String?
    public let description: String?

    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case name
        case price
        case imageUrl = "image"
        case description
    }
    
    public init(productId: String?,
                name: String?,
                price: Double?,
                imageUrl: String?,
                description: String?) {
        self.productId = productId
        self.name = name
        self.price = price
        self.imageUrl = imageUrl
        self.description = description
    }
}

