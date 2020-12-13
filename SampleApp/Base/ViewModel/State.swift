//
//  State.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation

public enum State {
    case loading
    case populate
    case empty
    case failure(Alert)
}
