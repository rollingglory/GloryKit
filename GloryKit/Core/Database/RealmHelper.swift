//
//  RealmHelper.swift
//  GloryKit
//
//  Created by Krisnandika Aji on 27/09/19.
//  Copyright © 2019 Krisnandika Aji. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper

typealias ObjectMappable = Object & Mappable

/// This is a class to store simplified and enhanced realm
/// methods, made singleton so any other class can access
/// and perform database syntax.
public class RealmHelper {
    
    /// Instantiate base realm object.
    private var realm: Realm? = {
        // Make realm compact on launch.
        let config = Realm.Configuration(shouldCompactOnLaunch: { totalBytes, usedBytes in
            // totalBytes refers to the size of the file on disk in bytes (data + free space)
            // usedBytes refers to the number of bytes used by data in the file
            
            // Compact if the file is over 100MB in size and less than 50% 'used'
            let oneHundredMB = 100 * 1024 * 1024
            return (totalBytes > oneHundredMB) && (Double(usedBytes) / Double(totalBytes)) < 0.5
        })
        do {
            // Realm is compacted on the first open if the configuration block conditions were met.
            let realm = try Realm(configuration: config)
            return realm
        } catch {
            // handle error compacting or opening Realm
            return nil
        }
    }()
    
    /// Singleton object
    static let shared = RealmHelper()
    
    // MARK: - Realm Config Methods
    /// Delete realms exist within device's default configuration
    /// directory, including realm lock, note and management.
    public func deleteRealms() {
        // Get URLs of realm configurations
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        // Loop and delete
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                NSLog("Failed deleting realms.")
            }
        }
    }
    
    // MARK: - Realm Transaction Methods
    /// Get objects of specified type in array of objects
    /// instead of `Result`.
    /// - Parameter object: Realm Object type
    /// - Parameter filter: Realm filter in string
    /// - Parameter sortKey: Sorting key property
    /// - Parameter ascending: (Used with `sortKey`) Sort direction type
    /// - Parameter realm: Realm (if any)
    public func get(_ object: Object.Type, filter: String? = nil, sortKey: String? = nil, ascending: Bool? = nil, inRealm realm: Realm?) -> [Object] {
        if let realm = realm { self.realm = realm }
        guard let realm = self.realm else { return [] }
        
        var objects = realm.objects(object)
        if let filter = filter {
            objects = objects.filter(filter)
        }
        if let sortKey = sortKey,
            let ascending = ascending {
            objects = objects.sorted(byKeyPath: sortKey, ascending: ascending)
        }
        
        return Array(objects)
    }
    
    /// Original writing syntax of Realm
    /// - Parameter realm: Realm (if any)
    /// - Parameter closure: Realm syntax and transaction codes
    public func write(inRealm realm: Realm?, closure: ((Realm) -> Void)) {
        if let realm = realm { self.realm = realm }
        guard let realm = self.realm else { return }
        
        do {
            try realm.write {
                closure(realm)
            }
        } catch {
            NSLog("REALM: Error writing into realm transaction.")
        }
    }
    
    /// Original realm add or update transaction syntax modified as a method
    /// - Parameter realm: Realm (if any)
    /// - Parameter objects: List of objects conform to `Object` to be added
    public func addOrUpdate(inRealm realm: Realm?, objects: [Object]) {
        if let realm = realm { self.realm = realm }
        guard let realm = self.realm else { return }
        
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            NSLog("REALM: Error adding object into realm.")
        }
    }
    
    /// Original update realm function modified as a method
    /// - Parameter object: Realm object to be updated
    /// - Parameter closure: Object update transaction
    public func update(object: Object, closure: ((Object) -> Void)) {
        if let realm = realm { self.realm = realm }
        guard let realm = self.realm else { return }
        
        do {
            try realm.write {
                closure(object)
            }
        } catch {
            NSLog("REALM: Error updating realm object.")
        }
    }
    
    /// Original delete realm function of multiple object
    /// - Parameter objects: List of object
    public func delete(objects: [Object]) {
        if let realm = realm { self.realm = realm }
        guard let realm = self.realm else { return }
        
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            NSLog("REALM: Error deleting realm objects.")
        }
    }
    
    /// Original delete realm function of all object of specified type
    /// - Parameter object: Object type
    public func delete(objectOfType object: Object.Type) {
        if let realm = realm { self.realm = realm }
        guard let realm = self.realm else { return }
        
        do {
            try realm.write {
                realm.delete(realm.objects(object))
            }
        } catch {
            NSLog("REALM: Error deleting realm objects.")
        }
    }
}
