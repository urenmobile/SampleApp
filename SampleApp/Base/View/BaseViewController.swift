//
//  BaseViewController.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import UIKit
import URENCombine

open class BaseViewController<InputViewModel>: UIViewController where InputViewModel: ViewModel {
    
    // MARK: - Variables
    public var viewModel: InputViewModel!
    public let cancelBag = CancelBag()
    
    private let loadingViewController = LoadingViewController()
    
    // MARK: - Life Cycle
    open override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        // Dismiss when pop view controller from navigation stack
        if parent == nil {
            viewModel.dismiss()
        }
    }
    
    open func setupView() {
        
    }
    
    open func setupViewModel() {
        
    }
    
    public func showLoadingView() {
        add(loadingViewController)
    }
    
    public func removeLoadingView() {
        loadingViewController.remove()
    }
}

extension UIViewController {
    
    open func show(alert: Alert) {
        // AlertController creation must be in main thread
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: alert.title,
                                                    message: alert.message,
                                                    preferredStyle: alert.preferredStyle)
            
            alert.actions.forEach { action in
                let alertAction = UIAlertAction(title: action.title, style: .default) { (_) in
                    action.handler?()
                }
                alertController.addAction(alertAction)
            }

//            UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}

private extension Alert {
    var preferredStyle: UIAlertController.Style {
        switch style {
        case .actionSheet:
            return .actionSheet
        case .alert:
            return .alert
        }
    }
}
