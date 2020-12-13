//
//  AlertAction.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/7/20.
//

import Foundation

public class AlertAction {
    public typealias Handler = () -> Void
    public let title: String
    public let handler: Handler?
    
    public init(title: String, handler: Handler? = nil) {
        self.title = title
        self.handler = handler
    }
}
