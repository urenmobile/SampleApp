//
//  ProductDetailView.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import UIKit
import URENCore

class ProductDetailView: BaseView {
    
    private var contentStackView: UIStackView!
    private var imageViewHeightConstraint: NSLayoutConstraint!
    
    private let imageView: URENImageView = {
        let imageView = URENImageView()
        imageView.layout {
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        }
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "[Title]"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 750), for: .vertical)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "[Subtitle]"
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "[Description]"
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    
    override func setupView() {
        super.setupView()
        
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, descriptionLabel])
        titleStackView.axis = .vertical
        titleStackView.spacing = 16
        titleStackView.alignment = .center
        titleStackView.isLayoutMarginsRelativeArrangement = true
        titleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        contentStackView = UIStackView(arrangedSubviews: [imageView, titleStackView, spacerView])
        contentStackView.axis = .vertical
        contentStackView.alignment = .center
        contentStackView.spacing = 16
        
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 100)
        
        addSubview(contentStackView)
        
        contentStackView.layout {
            $0.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
            $0.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            $0.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
            $0.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        }
    }
    
}

extension ProductDetailView: Configurable {
    
    func configure(with viewModel: ProductDetailViewData) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        subtitleLabel.isHidden = viewModel.subtitle == nil
        descriptionLabel.text = viewModel.description
        descriptionLabel.isHidden = viewModel.description == nil
        if let imageUrl = viewModel.imageUrl, let url = URL(string: imageUrl) {
            imageView.loadImageFrom(url: url)
        }
        
        if let imageHeight = viewModel.imageHeight {
            imageViewHeightConstraint.constant = imageHeight
            imageViewHeightConstraint.isActive = true
        } else {
            imageViewHeightConstraint.isActive = false
        }
    }
}
