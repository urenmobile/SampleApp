//
//  PassthroughSubject.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation

public final class PassthroughSubject<Output, Failure: Error>: Subject, Cancellable {
    
    public typealias Promise = (Output) -> Void
    public typealias Completion = Subscribers.Completion<Failure>
    public typealias CompletionPromise = (Completion) -> Void
    
    private var subscriptions: [Subscription] = []
    private var completion: Subscribers.Completion<Failure>?
    private var scheduler: Scheduler?
    
    private let lock = RecursiveLock()
    
    public init() {
        
    }
    
    public func send(_ value: Output) {
        lock.lock {
            subscriptions.forEach { $0.send(value) }
        }
    }
    
    public func send(completion: Subscribers.Completion<Failure>) {
        self.completion = completion
        lock.lock {
            subscriptions.forEach { $0.send(completion: completion) }
        }
    }
    
    public func receive<S: Scheduler>(on scheduler: S) -> PassthroughSubject {
        self.scheduler = scheduler
        return self
    }
    
    public func sink(receiveValue: @escaping Promise, receiveCompletion: @escaping CompletionPromise) -> AnyCancellable {
        guard completion == nil else {
            return AnyCancellable(self)
        }
        let subscription: Subscription = Subscription(receiveValue: receiveValue, receiveCompletion: receiveCompletion, scheduler: scheduler)
        subscriptions.append(subscription)
        return AnyCancellable(self)
    }
    
    public func cancel() {
        
    }
}

extension PassthroughSubject where Failure == Never {
    public func sink(receiveValue: @escaping Promise) -> AnyCancellable {
        guard completion == nil else {
            return AnyCancellable(self)
        }
        let subscription: Subscription = Subscription(receiveValue: receiveValue, receiveCompletion: { _ in }, scheduler: scheduler)
        subscriptions.append(subscription)
        return AnyCancellable(self)
    }
}

extension PassthroughSubject {
    private final class Subscription {
        
        private let receiveValue: Promise
        private let receiveCompletion: CompletionPromise
        private let scheduler: Scheduler?
        private let lock = Lock()
        private var isCompleted = false
        
        init(receiveValue: @escaping Promise, receiveCompletion: @escaping CompletionPromise, scheduler: Scheduler?) {
            self.receiveValue = receiveValue
            self.receiveCompletion = receiveCompletion
            self.scheduler = scheduler
        }
        
        fileprivate func send(_ value: Output) {
            guard !isCompleted else {
                return
            }
            if let scheduler = scheduler {
                scheduler.schedule { [weak self] in
                    self?.lock.lock()
                    self?.receiveValue(value)
                    self?.lock.unlock()
                }
            } else {
                receiveValue(value)
            }
        }
        
        fileprivate func send(completion: Subscribers.Completion<Failure>) {
            guard !isCompleted else {
                return
            }
            isCompleted = true
            if let scheduler = scheduler {
                scheduler.schedule { [weak self] in
                    self?.lock.lock()
                    self?.receiveCompletion(completion)
                    self?.lock.unlock()
                }
            } else {
                receiveCompletion(completion)
            }
        }
        
    }
}
