//
//  Extensions+UIViewController.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import UIKit

extension UIViewController {
    /// An extension add child view controller and move parent
    /// - Returns: void
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// An extension remove from parent view and viewcontroller
    /// - Returns: void
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    /// An extension add child view controller to containerview
    /// - Returns: void
    func add(child: UIViewController, to containerView: UIView) {
        /// view controller view to containerview
        addChild(child)
        child.view.frame = containerView.bounds
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
