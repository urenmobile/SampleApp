//
//  Environment.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation

public enum Environment {
    case development
    case test
    case prod
    case release
    
    public var name: String {
        switch self {
        case .development:
            return "DEV"
        case .test:
            return "TEST"
        case .prod:
            return "PROD"
        case .release:
            return ""
        }
    }
    
    public var host: String {
        // Should be separated by the environment
        switch self {
        case .development, .test:
            return "https://s3-eu-west-1.amazonaws.com/developer-application-test"
        case .prod, .release:
            // TODO: should change
            return "https://s3-eu-west-1.amazonaws.com/developer-application-test"
        }
    }
}
