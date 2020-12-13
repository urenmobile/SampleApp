//
//  Cancellable.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation

public protocol Cancellable {
    func cancel()
}

extension Cancellable {
    public func cancel(by bag: CancelBag) {
        bag.store(self)
    }
}

public final class CancelBag {
    private var cancellables = [Cancellable]()
    
    deinit {
        cancel()
    }
    
    public init() { }
    
    fileprivate func store(_ cancellable: Cancellable) {
        cancellables.append(cancellable)
    }
    
    private func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll(keepingCapacity: false)
    }
}
