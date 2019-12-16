//
//  Rx+ObjectMapper.swift
//  GloryKit
//
//  Created by Krisnandika Aji on 24/09/19.
//  Copyright © 2019 Krisnandika Aji. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Moya

/// :nodoc:
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    /// Map response to entirely different mappable object
    /// :nodoc:
    func map<T: Mappable>() -> Single<T> {
        return mapObject(T.self)
    }
}
