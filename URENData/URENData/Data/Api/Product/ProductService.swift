//
//  ProductService.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation
import URENDomain

public class ProductService: ProductServiceProvider {
    
    public init() { }
    
    public func getProducts(request: ProductRequest) -> UrlRequestConvertible {
        return ProductServiceModel(request: request)
    }
    
    public func getProductDetail(request: ProductDetailRequest) -> UrlRequestConvertible {
        return ProductDetailServiceModel(request: request)
    }
}

extension ProductService {
    // MARK: ProductServiceModel
    public class ProductServiceModel: BaseRequestConvertible<ProductRequest> {
        
        public init(request: ProductRequest) {
            super.init(environment: EnvironmentManager.shared.environment, method: .get, path: Endpoints.Paths.products, data: nil)
        }
    }

    // MARK: ProductDetailServiceModel
    public class ProductDetailServiceModel: BaseRequestConvertible<ProductDetailRequest> {
        
        public init(request: ProductDetailRequest) {
            super.init(environment: EnvironmentManager.shared.environment, method: .get, path: Endpoints.Paths.productDetail(productId: request.productId), data: nil)
        }
    }
}
