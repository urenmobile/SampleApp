//
//  Publisher.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation

public protocol Publisher {
    associatedtype Output
    associatedtype Failure: Error
}
