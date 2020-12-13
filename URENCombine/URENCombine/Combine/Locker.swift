//
//  Locker.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation

protocol Locker {
    func lock()
    func unlock()
}

extension Locker {
    public func lock<T>(task: () throws -> T) rethrows -> T {
        lock()
        defer {
            unlock()
        }
        return try task()
    }
}

public class RecursiveLock: Locker {
    private let locker = NSRecursiveLock()

    func lock() {
        locker.lock()
    }

    func unlock() {
        locker.unlock()
    }
}

public class Lock: Locker {
    private let locker = NSLock()

    func lock() {
        locker.lock()
    }

    func unlock() {
        locker.unlock()
    }
}
