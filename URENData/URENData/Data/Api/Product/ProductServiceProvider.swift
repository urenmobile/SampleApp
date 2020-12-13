//
//  ProductServiceProvider.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation
import URENDomain

public protocol ProductServiceProvider {
    func getProducts(request: ProductRequest) -> UrlRequestConvertible
    func getProductDetail(request: ProductDetailRequest) -> UrlRequestConvertible
}
