//
//  Alert.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/7/20.
//

import Foundation

public protocol Alert {
    var title: String? { get }
    var message: String? { get }
    var style: AlertStyle { get }
    var actions: [AlertAction] { get }
}
