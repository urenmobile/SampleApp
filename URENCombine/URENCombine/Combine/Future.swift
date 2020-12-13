//
//  Future.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation

public final class Future<Output, Failure>: Publisher where Failure: Error {
    
    public typealias InputResult = Result<Output, Failure>
    public typealias Completion = Subscribers.Completion<Failure>
    
    public typealias Promise = (InputResult) -> Void
    public typealias CompletionPromise = (Completion) -> Void
    
    private var result: Result<Output, Failure>?
    private var subscriptions: [Subscription] = []
    
    public init(_ fullFill: @escaping (@escaping Promise) -> Void) {
        fullFill {
            self.result = $0
            self.publish($0)
        }
    }
    
    private func publish(_ result: InputResult) {
        subscriptions.forEach {
            switch result {
            case .success(_):
                $0.send(result)
                $0.send(completion: .finished)
            case .failure(let error):
                $0.send(completion: .failure(error))
            }
        }
    }
    
    public func sink(receiveValue: @escaping Promise) {
        let subscription: Subscription = Subscription(receiveValue: receiveValue, receiveCompletion: { _ in })
        subscriptions.append(subscription)
    }
    
    public func sink(receiveValue: @escaping Promise, receiveCompletion: @escaping CompletionPromise) {
        let subscription: Subscription = Subscription(receiveValue: receiveValue, receiveCompletion: receiveCompletion)
        subscriptions.append(subscription)
    }
}

extension Future where Failure == Never {
    public func subscribe(receiveValue: @escaping Promise) {
        let subscription: Subscription = Subscription(receiveValue: receiveValue, receiveCompletion: { _ in })
        subscriptions.append(subscription)
    }
}

extension Future {
    private final class Subscription {
        
        private let receiveValue: Promise
        private let receiveCompletion: CompletionPromise
        private var isCompleted = false
        
        init(receiveValue: @escaping Promise, receiveCompletion: @escaping CompletionPromise) {
            self.receiveValue = receiveValue
            self.receiveCompletion = receiveCompletion
        }
        
        func send(_ value: InputResult) {
            guard !isCompleted else {
                return
            }
            receiveValue(value)
        }
        
        func send(completion: Completion) {
            guard !isCompleted else {
                return
            }
            isCompleted = true
            receiveCompletion(completion)
        }
    }
}
