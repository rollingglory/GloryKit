//
//  Utils.swift
//  GloryKit
//
//  Created by Rolling Glory on 09/01/20.
//  Copyright © 2020 Rolling Glory. All rights reserved.
//

import Foundation

public func associatedObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    initialiser: () -> ValueType)
    -> ValueType {
        if let associated = objc_getAssociatedObject(base, key)
            as? ValueType { return associated }
        let associated = initialiser()
        objc_setAssociatedObject(base, key, associated,
                                 .OBJC_ASSOCIATION_RETAIN)
        return associated
}

public func associatedObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>) -> ValueType? {
    return objc_getAssociatedObject(base, key) as? ValueType
}

public func associateObject<ValueType: AnyObject>(base: AnyObject,
                                           key: UnsafePointer<UInt8>,
                                           value: ValueType?) {
    objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
}
