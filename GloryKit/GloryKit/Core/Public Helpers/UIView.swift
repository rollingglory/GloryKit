//
//  UIView.swift
//  GloryKit
//
//  Created by Krisnandika Aji on 24/09/19.
//  Copyright © 2019 Krisnandika Aji. All rights reserved.
//

import Foundation

/// UIView's public helpers.
public extension UIView {
    // MARK: - Responder
    /// First Responder returns if the current selected
    /// view is a first responder.
    /// - Usage: `view.firstResponder()`
    func firstResponder() -> UIView? {
        var views = [UIView](arrayLiteral: self)
        var index = 0
        repeat {
            let view = views[index]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            index += 1
        } while index < views.count
        return nil
    }
    
    // MARK: - View Level
    /// Method to check superview level
    /// and get the designated UIView class
    /// - Usage: `view.superviewLevel(level: 1)`
    func superviewLevel(level: UInt) -> UIView {
        if level == 0 {
            return self
        }
        var view = self
        for _ in 1...level {
            if let sv = view.superview {
                view = sv
            }
            else {
                break
            }
        }
        return view
    }
}
