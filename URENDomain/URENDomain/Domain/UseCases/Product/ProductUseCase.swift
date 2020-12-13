//
//  ProductUseCase.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/1/20.
//

import Foundation
import URENCombine

public class ProductUseCase: BaseUseCase<ProductRequest, ProductResponse> {
    
    private let repository: ProductRepositoryProvider
    
    public init(repository: ProductRepositoryProvider) {
        self.repository = repository
    }
    
    public override func execute(_ input: ProductRequest) -> Future<ProductResponse, Error> {
        return repository.getProducts(request: input)
    }
    
    deinit {
        debugPrint("**** deinit \(String(describing: self))")
    }
}
