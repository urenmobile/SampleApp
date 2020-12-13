//
//  NetworkReachabilityManager.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation
import Network
import URENCombine

public final class NetworkReachabilityManager {
    
    public static let shared = NetworkReachabilityManager()
    
    public var statusSubject = PassthroughSubject<NetworkReachabilityManager.Status, Never>()
    
    private let queue = DispatchQueue(label: "com.uren.monitor")
    private let monitor = NWPathMonitor()
    
    public func start() {
        monitor.pathUpdateHandler = { [weak self] in
            guard case .satisfied = $0.status else {
                debugPrint("No connection")
                self?.statusSubject.send(.notReachable)
                return
            }
            debugPrint("Connected via cellural/wifi")
            self?.statusSubject.send(.reachable)
        }
        
        monitor.start(queue: queue)
    }
    
}

extension NetworkReachabilityManager {
    public enum Status {
        case reachable
        case notReachable
    }
}
