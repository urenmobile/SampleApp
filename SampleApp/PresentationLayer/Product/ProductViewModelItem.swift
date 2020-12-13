//
//  ProductViewModelItem.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation
import URENDomain

struct ProductViewModelItem {
    let productId: String?
    let name: String?
    let price: Double
    let imageUrl: String?
    let description: String?
    
    init(productId: String?,
         name: String?,
         price: Double,
         imageUrl: String?,
         description: String?) {
        self.productId = productId
        self.name = name
        self.price = price
        self.imageUrl = imageUrl
        self.description = description
    }
    
    init(model: ProductModel) {
        self.init(productId: model.productId,
                  name: model.name,
                  price: model.price ?? 0,
                  imageUrl: model.imageUrl,
                  description: model.description)
    }
}
