//
//  ProductDetailUseCase.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation
import URENCombine

public class ProductDetailUseCase: BaseUseCase<ProductDetailRequest, ProductDetailResponse> {
    
    private let repository: ProductRepositoryProvider
    
    public init(repository: ProductRepositoryProvider) {
        self.repository = repository
    }
    
    public override func execute(_ input: ProductDetailRequest) -> Future<ProductDetailResponse, Error> {
        return repository.getProductDetail(request: input)
    }
    
    deinit {
        debugPrint("**** deinit \(String(describing: self))")
    }
}
