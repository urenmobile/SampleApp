//
//  HttpClientProvider.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation
import URENCombine
import URENDomain

public protocol HttpClientProvider {
    func execute<T>(convertible: UrlRequestConvertible) -> Future<T, Error> where T: Model
}
