//
//  AppCoordinator.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import UIKit
import URENCombine
import URENDomain
import URENData

final class AppCoordinator: BaseCoordinator<AppViewModel> {
    
    private let networkReachability: NetworkReachabilityManager
    private let window = UIWindow(frame: UIScreen.main.bounds)
    
    public init(networkReachability: NetworkReachabilityManager, appViewModel: AppViewModel) {
        self.networkReachability = networkReachability
        super.init(viewModel: appViewModel)
    }
    
    override func start() {
        super.start()
        showSplash()
    }
    
    private func showSplash() {
        let viewModel = SplashScreenViewModel()
        let coordinator = SplashScreenCoordinator(viewModel: viewModel)
        start(coordinator: coordinator)
        
        coordinator.didFinishSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showProduct()
            }.cancel(by: cancelBag)
        
        window.setRootViewController(coordinator.viewController, animated: true)
    }
    
    private func showProduct() {
        removeChildCoordinators()
        
        // Dependency Configuration
        let httpClient: HttpClientProvider = HttpClient.shared 
        let service: ProductServiceProvider = ProductService()
        let persistent: PersistentProvider = PersistentManager.shared
        
        let remote: ProductRemoteProvider = ProductRemote(httpClient: httpClient, service: service)
        
        let local: ProductLocalProvider = ProductLocal(persistent: persistent)
        
        let repository: ProductRepositoryProvider = ProductRepository(remote: remote, local: local)
        let useCase = ProductUseCase(repository: repository)
        let coreData: ProductCoreDataProvider = ProductCoreData()
        
        let viewModel = ProductViewModel(productUseCase: useCase, productCoreData: coreData)
        
        // Start Coordinator
        let coordinator = ProductViewCoordinator(viewModel: viewModel)
        start(coordinator: coordinator)
        
        window.setRootViewController(coordinator.navigationController, animated: true)
        
        sinkNetworkReachability()
    }
    
    private func sinkNetworkReachability() {
        networkReachability.statusSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showNetworkErrorIfNeeded(with: $0)
            }.cancel(by: cancelBag)
        
        networkReachability.start()
    }
    
    private func showNetworkErrorIfNeeded(with status: NetworkReachabilityManager.Status) {
        if case .notReachable = status {
            let okAction = AlertAction(title: Localizer.ok.localized)
            let alert = AnyAlert(title: Localizer.error.localized, message: Localizer.noInternetConnection.localized, style: .alert, actions: [okAction])
            UIApplication.topViewController()?.show(alert: alert)
        }
    }
    
}
