//
//  Scheduler.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation

public protocol Scheduler {
    func schedule(_ action: @escaping () -> Void)
}

extension DispatchQueue: Scheduler {
    public func schedule(_ action: @escaping () -> Void) {
        async(execute: action)
    }
}
