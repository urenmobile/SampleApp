//
//  ProductDetailRequest.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/1/20.
//

import Foundation

public struct ProductDetailRequest: Model {
    public let productId: String
    
    public init(productId: String) {
        self.productId = productId
    }
}
