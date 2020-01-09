//
//  UIView.swift
//  GloryKit
//
//  Created by Rolling Glory on 24/09/19.
//  Copyright © 2019 Rolling Glory. All rights reserved.
//

import Foundation

private var loadingKey: UInt8 = 0
private var emptyKey: UInt8 = 0

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
    
    // MARK: - Empty View
    var emptyView: UIView? {
        get {
            return associatedObject(base: self, key: &emptyKey)
        }
        set {
            associateObject(base: self, key: &emptyKey, value: newValue)
        }
    }
    
    func setIsEmpty(_ isEmpty: Bool) {
        if isEmpty {
            guard let emptyView = emptyView else { return }
            emptyView.tag = 555
            self.superview?.addSubview(emptyView)
            emptyView.snp.makeConstraints({ (make) in
                make.leading.trailing.top.bottom.equalTo(self)
            })
        } else {
            guard let subviews = self.superview?.subviews else { return }
            for s in subviews {
                if s.tag == 555 {
                    s.removeFromSuperview()
                }
            }
        }
    }
    
    // MARK: - Loading View
    var loadingView: UIView? {
        get {
            return associatedObject(base: self, key: &loadingKey)
        }
        set {
            associateObject(base: self, key: &loadingKey, value: newValue)
        }
    }
    
    func setIsLoadingWithAlpha(_ isLoading: Bool, _ alpha: Float = 1) {
        if isLoading {
            guard let loadingView = loadingView else { return }
            self.superview?.addSubview(loadingView)
            loadingView.snp.makeConstraints({ (make) in
                make.leading.trailing.top.bottom.equalTo(self)
            })
            loadingView.alpha = CGFloat(alpha)
        } else {
            loadingView?.removeFromSuperview()
        }
    }
}
