//
//  ProductLocalProvider.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/9/20.
//

import Foundation
import URENDomain

public protocol ProductLocalProvider {
    func saveProducts(response: ProductResponse)
    func saveProductDetail(response: ProductDetailResponse)
}
