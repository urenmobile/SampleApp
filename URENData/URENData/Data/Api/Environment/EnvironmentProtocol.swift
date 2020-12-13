//
//  EnvironmentProtocol.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation

public protocol EnvironmentProtocol {
    var environment: Environment { get }
    func canChangeEnvironment() -> Bool
    func changeEnvironment(to environment: Environment)
}
