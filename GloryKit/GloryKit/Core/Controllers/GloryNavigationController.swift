//
//  BaseNavigationController.swift
//  Doctor App for KlikDokter
//
//  Created by Rolling Glory on 08/01/19.
//  Copyright © 2019 RGB. All rights reserved.
//

import UIKit

/// GloryKit's customized navigation controller
/// to better manages app navigation flow
/// and perform necessary customization
open class GloryNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    /// Within viewDidLoad, sets several navigation
    /// bar customization
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = UIColor.clear
        navigationBar.backgroundColor = UIColor.clear
    }
    
    private func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
