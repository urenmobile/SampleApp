//
//  EnvironmentManager.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation

public class EnvironmentManager: EnvironmentProtocol {
    
    public static let shared = EnvironmentManager()
    /// Current environment
    public private(set) var environment: Environment = .development
    
    /// Return current environment can change able or not
    public func canChangeEnvironment() -> Bool {
        return environment != .release && environment != .prod
    }
    
    public func changeEnvironment(to environment: Environment) {
        guard canChangeEnvironment() else { return }
        self.environment = environment
    }
}
