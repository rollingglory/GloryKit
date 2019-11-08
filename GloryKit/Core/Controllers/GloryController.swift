//
//  GloryController.swift
//  GloryKit
//
//  Created by RGB on 09/09/19.
//  Copyright © 2019 Rolling Glory. All rights reserved.
//

import UIKit
import Foundation

/// GloryKit's base controller to keep classes thin
/// and more organized, having customized life cycle
/// and better initialization.
open class GloryController: UIViewController {
    
    /// Initialize GloryController so that user doesn't need to
    /// input nibname or bundle to instantiate an instance of
    /// GloryController.
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
    }
    
    /// Initialize GloryController with custom .nib file
    /// - Parameter nibName: The name of nib
    /// - Parameter bundle: nib's bundle, probably set to nil
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    /// Required init coder method
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// viewDidLoad override
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
}

// GloryController's main helper.
extension GloryController {
    
    /// Get the root of current view controller
    /// stack from navigation/presentation.
    public static var root: UIViewController? {
        var rootVC = UIApplication.shared.keyWindow?.rootViewController
        while (rootVC?.presentedViewController != nil) {
            if let presentedVC = rootVC?.presentedViewController,
                presentedVC.isKind(of: UIAlertController.classForCoder()) == false {
                rootVC = rootVC?.presentedViewController
            } else {
                break
            }
        }
        
        if let navVC = rootVC as? UINavigationController {
            return navVC.topViewController
        } else if let tabVC = rootVC as? UITabBarController {
            if let navVC = tabVC.selectedViewController as? UINavigationController {
                return navVC.topViewController
            } else {
                return tabVC.selectedViewController
            }
        } else {
            return rootVC
        }
    }
}
