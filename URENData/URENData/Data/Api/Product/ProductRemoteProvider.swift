//
//  ProductRemoteProvider.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation
import URENCombine
import URENDomain

public protocol ProductRemoteProvider {
    func getProducts(request: ProductRequest) -> Future<ProductResponse, Error>
    func getProductDetail(request: ProductDetailRequest) -> Future<ProductDetailResponse, Error>
}
