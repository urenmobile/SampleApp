//
//  BaseViewModel.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation
import URENCombine

open class BaseViewModel: ViewModel {
    
    public private(set) var state = PassthroughSubject<State, Never>()
    public private(set) var dismissSubject = PassthroughSubject<Void, Never>()
    public let cancelBag = CancelBag()
    
    private var isDismissed = false
    
    open func dismiss() {
        guard !isDismissed else {
            return
        }
        isDismissed = true
        dismissSubject.send()
    }
    
    open func handle(error: Error) {
        print("*RESPONSE FAILURE: \(error.localizedDescription)")
        self.state.send(.failure(error.alert()))
    }
}
