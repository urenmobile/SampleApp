//
//  Endpoints.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation

public enum Endpoints {
    
}

extension Endpoints {
    public enum Paths {
        case products
        case productDetail(productId: String)
        
        public var path: String {
            switch self {
            case .products:
                return "cart/list"
            case .productDetail(let productId):
                return "cart/\(productId)/detail"
            }
        }
    }
}
