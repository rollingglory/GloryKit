//
//  Queue.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/27/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//
//  SwiftyTask usage can be found at: https://github.com/Albinzr/SwiftyTask

import Foundation

/// Queue enum for SwiftyTask
public enum Queue {
    /// Main queue instance
    case main
    /// Background queue instance
    case background
    /// UI queue instance
    case userInteractive
    /// User Initiated queue instance
    case userInitiated
    /// Utility queue instance
    case utility
    /// Default queue instance
    case `default`
    /// Custom queue instance
    case custom(queue: DispatchQueue)
    
    /// Queue var
    public var queue : DispatchQueue {
        switch self {
        case .main:
            return DispatchQueue.main
        case .background:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        case .userInteractive:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
        case .userInitiated:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
        case .utility:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
        case .default:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        case .custom(let queue):
            return queue
        }
    }
}


