//
//  Subscribers.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation

public enum Subscribers {
    
}

extension Subscribers {
    public enum Completion<Failure: Error> {
        case finished
        case failure(Failure)
    }
}
