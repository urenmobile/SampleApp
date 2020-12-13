//
//  Extensions+UIWindow.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import UIKit

extension UIWindow {
    public func setRootViewController(_ viewController: UIViewController, animated: Bool) {
        guard animated else {
            self.rootViewController = viewController
            self.makeKeyAndVisible()
            return
        }

        if let snapshot = self.snapshotView(afterScreenUpdates: true) {
            viewController.view.addSubview(snapshot)
            self.rootViewController = viewController
            self.makeKeyAndVisible()
            
            UIView.animate(withDuration: 0.4, animations: {
                snapshot.layer.opacity = 0
            }, completion: { _ in
                snapshot.removeFromSuperview()
            })
        }
    }
}
