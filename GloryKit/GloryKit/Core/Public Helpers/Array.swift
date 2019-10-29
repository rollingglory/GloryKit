//
//  Array.swift
//  GloryKit
//
//  Created by Krisnandika Aji on 16/10/19.
//  Copyright © 2019 Krisnandika Aji. All rights reserved.
//

import Foundation

/// Array function helpers.
public extension Array where Element: Equatable {
    
    // MARK: - Remove
    /// Remove any element in an array.
    /// - Usage: given `let array = [1, 2, 3]`
    /// then `array.remove(1)`
    @discardableResult
    mutating func remove(element: Element) -> Index? {
        guard let index = index(of: element) else { return nil }
        remove(at: index)
        return index
    }
}
