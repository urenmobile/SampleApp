//
//  ProductRemote.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation
import URENCombine
import URENDomain

public class ProductRemote: ProductRemoteProvider {
    
    private let httpClient: HttpClientProvider
    private let service: ProductServiceProvider
    
    public init(httpClient: HttpClientProvider, service: ProductServiceProvider) {
        self.httpClient = httpClient
        self.service = service
    }
    
    public func getProducts(request: ProductRequest) -> Future<ProductResponse, Error> {
        return httpClient.execute(convertible: service.getProducts(request: request))
    }
    
    public func getProductDetail(request: ProductDetailRequest) -> Future<ProductDetailResponse, Error> {
        return httpClient.execute(convertible: service.getProductDetail(request: request))
    }
    
}
