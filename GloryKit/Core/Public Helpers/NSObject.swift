//
//  NSObject.swift
//  GloryKit
//
//  Created by Rolling Glory on 16/10/19.
//  Copyright © 2019 Rolling Glory. All rights reserved.
//

import Foundation

/// NSObject's public helper.
public extension NSObject {
    // MARK: - Class Name Helper
    /// Get class name.
    /// - Usage: `UIView.className`
    static var className: String {
        return String(describing: self)
    }
    
    /// Get class name.
    /// - Usage: `UILabel().className`
    var className: String {
        return type(of: self).className
    }
}

// MARK: - Closure Applier
/// NSObject closure applier
public extension NSObject {
    /// Allows NSObject to chain editable property Kotlin-like
    ///
    ///     let view = UIView().apply {
    ///         $0.backgroundColor = .red
    ///         $0.frame = .init(x: 0, y: 0, width: 200, height: 200)
    ///     }
    ///
    @discardableResult
    func apply(closure: (NSObject) -> Void) -> Self {
        closure(self)
        return self
    }
    
    /// :nodoc:
    @discardableResult
    func run<T>(closure: (NSObject) -> T) -> T {
        return closure(self)
    }
}
