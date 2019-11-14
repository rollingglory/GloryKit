//
//  GloryPaginator.swift
//  GloryKit
//
//  Created by Krisnandika Aji on 14/11/19.
//  Copyright © 2019 Krisnandika Aji. All rights reserved.
//

import Foundation

/// GloryPaginator gives a generic, all-rounder paginator for most
/// server tasks to be applied within table view/collection views.
public class GloryPaginator {
    /// Modifiers
    let count: Int
    let task: FetchTask
    
    var page: Int = 0
    var hasMore: Bool = false
    var parameter: Any? = nil
    
    private var isLoading: Bool = false
    
    typealias FetchCompletion = ([Any]?, String?, Error?) -> Void
    typealias FetchTask = (_ parameter: Any?, _ count: Int, _ page: Int, _ completion: FetchCompletion?) -> Void
    
    // Initialize paginator by declaring its task and setting `count`
    init(withTask task: @escaping FetchTask, count: Int = 10) {
        self.task = task
        self.count = count
    }
    
    /// Method to fetch initial page of a task
    /// count as reset.
    func fetchObjects(withParameter _parameter: Any?, completion: FetchCompletion?) {
        if isLoading { return }
        
        parameter = _parameter
        page = 1
        hasMore = false
        isLoading = true
        
        task(parameter, count, page) { [weak self] (objects, type, error) in
            self?.handleResult(objects, type: type, error: error, completion: completion)
        }
    }
    
    /// Method to load more data of given task
    func fetchMoreObjects(_ completion: FetchCompletion?) {
        if isLoading { return }
        
        isLoading = true
        
        task(parameter, count, page) { [weak self] (objects, type, error) in
            self?.handleResult(objects, type: type, error: error, completion: completion)
        }
    }
    
    private func handleResult(_ _objects: [Any]?, type: String?, error: Error?, completion: FetchCompletion?) {
        isLoading = false
        
        guard let objects = _objects else {
            completion?(_objects, type, error)
            
            return
        }
        
        hasMore = objects.count == count
        page += 1
        
        completion?(objects, type, error)
    }
}
