//
//  Extensions+UIView.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import UIKit

// MARK: - DSL
extension UIView {
    @_functionBuilder
    struct ConstraintsBuilder {
        static func buildBlock(_ constraints: NSLayoutConstraint...) -> [NSLayoutConstraint] {
            constraints
        }
    }
    
    public func layout(@ConstraintsBuilder using closure: (UIView) -> [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(closure(self))
    }
}
