//
//  UseCase.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/1/20.
//

import Foundation

public protocol UseCase {
    associatedtype Input
    associatedtype Output
    
    func execute(_ input: Input) -> Output
}
