//
//  ProductRepositoryProvider.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/1/20.
//

import Foundation
import URENCombine

public protocol ProductRepositoryProvider {
    func getProducts(request: ProductRequest) -> Future<ProductResponse, Error>
    func getProductDetail(request: ProductDetailRequest) -> Future<ProductDetailResponse, Error>
}
