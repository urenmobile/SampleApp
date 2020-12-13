//
//  DomainModelConvertible.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation

public protocol DomainModelConvertible {
    associatedtype ModelType
    
    func update(with model: ModelType)
    func toDomain() -> ModelType
}
