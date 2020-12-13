//
//  ProductDetailViewModel.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/3/20.
//

import Foundation
import URENCombine
import URENDomain

class ProductDetailViewModel: BaseViewModel {
    
    var product: ProductViewModelItem?
    
    private(set) var detailSubject = PassthroughSubject<ProductDetailViewData, Never>()
    
    private let productDetailUseCase: ProductDetailUseCase
    
    init(productDetailUseCase: ProductDetailUseCase) {
        self.productDetailUseCase = productDetailUseCase
    }
    
    func getData() {
        guard let product = product, let productId = product.productId else {
            return
        }
        state.send(.loading)
        send(item: product)
        
        let request = ProductDetailRequest(productId: productId)
        
        productDetailUseCase.execute(request).sink { [weak self] in
            switch $0 {
            case .success(let response):
                self?.handle(response: response)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
    func handle(response: ProductDetailResponse) {
        let item = ProductViewModelItem(model: response)
        product = item
        
        state.send(.populate)
        send(item: item)
    }
    
    private func send(item: ProductViewModelItem) {
        let viewData = ProductDetailViewData(title: item.name,
                                             subtitle: "\(item.price)",
                                             description: item.description,
                                             imageUrl: item.imageUrl)
        detailSubject.send(viewData)
    }
}
