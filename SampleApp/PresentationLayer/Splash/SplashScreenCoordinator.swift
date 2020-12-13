//
//  SplashScreenCoordinator.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import UIKit

final class SplashScreenCoordinator: BaseViewCoordinator<SplashScreenViewController, SplashScreenViewModel> {
    
    override func start() {
        super.start()
        
        sinkDismiss()
        dummyDoSomething()
    }
    
    private func sinkDismiss() {
        viewModel.dismissSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.finish()
            }.cancel(by: cancelBag)
    }
    
    private func dummyDoSomething() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.viewModel.dismiss()
        }
    }
}
