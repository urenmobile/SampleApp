//
//  SplashScreenViewController.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import UIKit

final class SplashScreenViewController: BaseViewController<SplashScreenViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        showLoadingView()
    }
}
