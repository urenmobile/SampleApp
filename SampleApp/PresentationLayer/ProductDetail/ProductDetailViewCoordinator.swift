//
//  ProductDetailViewCoordinator.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/7/20.
//

import UIKit

final class ProductDetailViewCoordinator: BaseViewCoordinator<ProductDetailViewController, ProductDetailViewModel> {

    override func start() {
        super.start()
        sinkDismiss()
    }
    
    private func sinkDismiss() {
        viewModel.dismissSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.finish()
            }.cancel(by: cancelBag)
    }
    
}
