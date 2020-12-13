//
//  ProductCollectionViewCell.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/3/20.
//

import UIKit

class ProductCollectionViewCell: BaseCollectionViewCell {
    
    private var productDetailView: ProductDetailView!
    
    override func setupView() {
        super.setupView()
        
        productDetailView = ProductDetailView()
        contentStackView.addArrangedSubview(productDetailView)
        contentStackView.layoutIfNeeded()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.2
    }
    
}

// MARK: - Configurable
extension ProductCollectionViewCell: Configurable {
    
    func configure(with viewModel: ProductDetailViewData) {
        productDetailView.configure(with: viewModel)
    }
    
}
