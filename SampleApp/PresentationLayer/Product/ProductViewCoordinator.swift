//
//  ProductViewCoordinator.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import UIKit
import URENDomain
import URENData

final class ProductViewCoordinator: BaseViewCoordinator<ProductViewController, ProductViewModel> {

    override func start() {
        super.start()
        navigationController = BaseNavigationController(rootViewController: viewController)
        sinkSelectedProduct()
    }
    
    private func sinkSelectedProduct() {
        viewModel.selectedProductSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showDetail(with: $0)
            }.cancel(by: cancelBag)
    }
    
    private func showDetail(with item: ProductViewModelItem) {
        // Dependency Configuration
        let httpClient: HttpClientProvider = HttpClient.shared
        let service: ProductServiceProvider = ProductService()
        let persistent: PersistentProvider = PersistentManager.shared
        
        let remote: ProductRemoteProvider = ProductRemote(httpClient: httpClient, service: service)

        let local: ProductLocalProvider = ProductLocal(persistent: persistent)
        
        let repository: ProductRepositoryProvider = ProductRepository(remote: remote, local: local)
        let useCase = ProductDetailUseCase(repository: repository)
        
        let viewModel = ProductDetailViewModel(productDetailUseCase: useCase)
        viewModel.product = item
        
        // Start Coordinator
        let coordinator = ProductDetailViewCoordinator(viewModel: viewModel)
        start(coordinator: coordinator)
        
        route(to: coordinator.viewController, animated: true)
    }
}
