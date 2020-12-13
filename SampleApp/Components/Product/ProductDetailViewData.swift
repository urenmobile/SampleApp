//
//  ProductDetailViewData.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import UIKit

class ProductDetailViewData {
    let title: String?
    let subtitle: String?
    let description: String?
    let imageUrl: String?
    let imageHeight: CGFloat?
    
    init(title: String?,
         subtitle: String?,
         description: String?,
         imageUrl: String?,
         imageHeight: CGFloat? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.imageUrl = imageUrl
        self.imageHeight = imageHeight
    }
}
