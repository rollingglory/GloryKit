//
//  ListTransform.swift
//  ObjectMapper+Realm
//
//  Created by Jake Peterson on 8/25/16.
//  Copyright © 2016 jakenberg. All rights reserved.
//
import Foundation
import ObjectMapper
import RealmSwift

/// ListTransform enables user to insert array/list
/// into Object&Mappable class as variable
/// :nodoc:
public struct ListTransform<T: RealmSwift.Object>: TransformType where T: BaseMappable {
    
    /// :nodoc:
    public init() { }
    
    /// :nodoc:
    public typealias Object = List<T>
    /// :nodoc:
    public typealias JSON = Array<Any>
    
    /// Transform list from JSON
    public func transformFromJSON(_ value: Any?) -> List<T>? {
        if let objects = Mapper<T>().mapArray(JSONObject: value) {
            let list = List<T>()
            list.append(objectsIn: objects)
            return list
        }
        return nil
    }
    
    /// Transform list to JSON
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.compactMap { $0.toJSON() }
    }
    
}
