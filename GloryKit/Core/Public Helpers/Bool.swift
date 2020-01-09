//
//  Bool.swift
//  GloryKit
//
//  Created by Rolling Glory on 18/10/19.
//  Copyright © 2019 Rolling Glory. All rights reserved.
//

import Foundation

/// Bool function helpers.
public extension Bool {
    
    // MARK: - Vars
    /// Return 1 if true, or 0 if false.
    var int: Int {
        return self ? 1 : 0
    }
    
    /// Return "true" if true, or "false" if false.
    var string: String {
        return self ? "true" : "false"
    }
}
