//
//  ProductDetailViewController.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/3/20.
//

import UIKit
import URENCombine

class ProductDetailViewController: BaseViewController<ProductDetailViewModel> {
    
    // MARK: - Variables
    
    private var productDetailView: ProductDetailView!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }
    
    override func setupView() {
        title = Localizer.productDetail.localized
        view.backgroundColor = .white
        productDetailView = ProductDetailView()
        
        view.addSubview(productDetailView)
        productDetailView.layout {
            $0.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            $0.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            $0.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            $0.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        }
    }
    
    override func setupViewModel() {
        viewModel.state.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let `self` = self else { return }
            self.handle(state: $0)
        }.cancel(by: cancelBag)
        
        viewModel.detailSubject.receive(on: DispatchQueue.main).sink { [weak self] item in
            self?.productDetailView.configure(with: item)
        }.cancel(by: cancelBag)
        
        viewModel.getData()
    }
    
    private func handle(state: State) {
        switch state {
        case .loading:
            showLoadingView()
        case .populate, .empty:
            removeLoadingView()
        case .failure(let alert):
            removeLoadingView()
            show(alert: alert)
        }
    }
}
