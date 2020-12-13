//
//  ProductViewModel.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation
import CoreData
import URENCombine
import URENDomain

class ProductViewModel: BaseViewModel {
    
    private(set) var selectedProductSubject = PassthroughSubject<ProductViewModelItem, Never>()
    private(set) var reloadableChangesSubject = PassthroughSubject<ReloadableChanges, Never>()
    
    private var items: [ProductViewModelItem] = []
    
    private let productUseCase: ProductUseCase
    private let productCoreData: ProductCoreDataProvider
    
    init(productUseCase: ProductUseCase, productCoreData: ProductCoreDataProvider) {
        self.productUseCase = productUseCase
        self.productCoreData = productCoreData
    }
    
    func getData() {
        state.send(.loading)
        fetchAndLoadCoreData()
        
        let request = ProductRequest()
        productUseCase.execute(request).sink { [weak self] in
            switch $0 {
            case .success(let response):
                self?.handle(response: response)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
    private func fetchAndLoadCoreData() {
        productCoreData.reloadableChangesSubject.sink { [weak self] in
            self?.reloadableChangesSubject.send($0)
        }.cancel(by: cancelBag)
        
        productCoreData.performFetch()
    }
    
    private func handle(response: ProductResponse) {
        items = response.products?.compactMap { ProductViewModelItem(model: $0) } ?? []
        state.send(.populate)
    }
    
    // MARK: - List Actions
    func numberOfSections() -> Int {
        return productCoreData.numberOfSection()
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return productCoreData.numberOfItemsInSection(section)
    }
    
    func item(at indexPath: IndexPath) -> ProductDetailViewData {
        let entity = productCoreData.item(at: indexPath)
        let viewData = ProductDetailViewData(title: entity.name,
                                             subtitle: "\(entity.price)",
                                             description: entity.productDescription,
                                             imageUrl: entity.imageUrl,
                                             imageHeight: 100)
        return viewData
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        selectedProductSubject.send(selectedItem)
    }
    
    func willDisplayItem(at indexPath: IndexPath) {
        // TODO: write code for pagination
    }
}
