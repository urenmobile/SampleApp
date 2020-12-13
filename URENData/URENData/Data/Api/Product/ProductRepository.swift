//
//  ProductRepository.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation
import URENCombine
import URENDomain

public class ProductRepository: ProductRepositoryProvider {
    
    private let remote: ProductRemoteProvider
    private let local: ProductLocalProvider?
    
    public init(remote: ProductRemoteProvider, local: ProductLocalProvider?) {
        self.remote = remote
        self.local = local
    }
    
    public func getProducts(request: ProductRequest) -> Future<ProductResponse, Error> {
        return Future { [weak self] (promise) in
            
            self?.remote.getProducts(request: request).sink { [weak self] in
                if case let .success(response) = $0 {
                    self?.local?.saveProducts(response: response)
                }
                promise($0)
            }
        }
    }
    
    public func getProductDetail(request: ProductDetailRequest) -> Future<ProductDetailResponse, Error> {
        return Future { [weak self] (promise) in
            
            self?.remote.getProductDetail(request: request).sink { [weak self] in
                if case let .success(response) = $0 {
                    self?.local?.saveProductDetail(response: response)
                }
                promise($0)
            }
        }
    }
    
    deinit {
        debugPrint("**** deinit \(String(describing: self))")
    }
}
