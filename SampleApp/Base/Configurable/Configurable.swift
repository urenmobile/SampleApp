//
//  Configurable.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation

public protocol Configurable: ReuseIdentifying {
    associatedtype ViewModelType
    
    func configure(with viewModel: ViewModelType)
    
}
