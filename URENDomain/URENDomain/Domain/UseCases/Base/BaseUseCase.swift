//
//  BaseUseCase.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/10/20.
//

import Foundation
import URENCombine

public class BaseUseCase<Input, Output>: UseCase {
    
    public typealias Input = Input
    public typealias Output = Future<Output, Error>
    
    public func execute(_ input: Input) -> Future<Output, Error> {
        FatalHelper.notImplementedError()
    }
}

internal class FatalHelper {
    internal class func notImplementedError(file: StaticString = #file, line: UInt = #line) -> Never {
        fatalError("Base class function not implemented", file: file, line: line)
    }
}
