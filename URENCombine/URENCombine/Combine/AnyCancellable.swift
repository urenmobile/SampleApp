//
//  AnyCancellable.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation

final public class AnyCancellable: Cancellable {
    typealias CancelAction = () -> Void
    
    private var cancelAction: CancelAction?
    
    init(_ cancel: @escaping CancelAction) {
        self.cancelAction = cancel
    }
    
    init<C>(_ canceller: C) where C: Cancellable {
        self.cancelAction = canceller.cancel
    }
    
    public func cancel() {
        if let action = cancelAction {
            action()
            cancelAction = nil
        }
    }
}
