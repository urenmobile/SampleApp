//
//  ReuseIdentifying.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation

public protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
