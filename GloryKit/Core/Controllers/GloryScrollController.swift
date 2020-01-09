//
//  BaseScrollController.swift
//  KlikDokter App for Doctor
//
//  Created by Rolling Glory on 14/02/19.
//  Copyright © 2019 RGB. All rights reserved.
//

import Foundation
import UIKit

/// GloryKit's base scroll controller
/// provides better scroll view management
/// and helpful behavior
open class GloryScrollController: GloryController {
    
    /// REQUIRED: Any class that subclasses GloryScrollController
    /// should define its scrollView and attaches it to this
    /// IBOutlet to work.
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// Self behavior
    var isKeyboardVisible = false
    
    /// viewDidLoad override
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    /// Each time a GloryScrollController is instantiated,
    /// iOS automatically resizes its frame size to
    /// its contentSize.
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }
    
    /// didReceiveMemotyWarning override
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Keyboard Management
    /// Method to resize scroll view whenever a keyboard is present.
    @objc func keyboardWillShow(sender: NSNotification) {
        
        if isKeyboardVisible {
            return
        }
        let userInfo = sender.userInfo as! [String: AnyObject]
        
        var keyboardFrameValue = userInfo["UIKeyboardBoundsUserInfoKey"] as? NSValue
        if keyboardFrameValue == nil {
            keyboardFrameValue = userInfo["UIKeyboardFrameEndUserInfoKey"] as? NSValue
        }
        
        if let uKeyboardFrameValue = keyboardFrameValue {
            
            var animationDuration = 0.3
            if let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                animationDuration = duration
            }
            
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                
                let screenHeight = UIScreen.main.bounds.size.height
                let contentHeight = self.scrollView.contentSize.height
                let keyboardHeight = uKeyboardFrameValue.cgRectValue.height
                
                var height = CGFloat(0)
                if keyboardHeight > 0 {
                    self.isKeyboardVisible = true
                    height = contentHeight - screenHeight + keyboardHeight
                }
                
                self.scrollView.contentInset = UIEdgeInsets(
                    top: self.scrollView.contentInset.top,
                    left: self.scrollView.contentInset.left,
                    bottom: height,
                    right: self.scrollView.contentInset.right
                )
                
                self.scrollView.scrollIndicatorInsets = UIEdgeInsets(
                    top: self.scrollView.scrollIndicatorInsets.top,
                    left: self.scrollView.scrollIndicatorInsets.left,
                    bottom: height,
                    right: self.scrollView.scrollIndicatorInsets.right
                )
                
            }, completion: { (finished) -> Void in
                
                if let frView = self.scrollView.firstResponder() {
                    
                    let firstResponderRect = frView.superviewLevel(level: 2).convert(frView.frame, from: frView.superviewLevel(level: 1))
                    
                    let frame = self.scrollView.frame
                    
                    let y = firstResponderRect.origin.y + firstResponderRect.height
                    if y >= frame.height - uKeyboardFrameValue.cgRectValue.height {
                        self.scrollView.setContentOffset(CGPoint(
                            x: 0.0,
                            y: y - (frame.height - uKeyboardFrameValue.cgRectValue.height) + 20.0), animated: true)
                    }
                }
            })
        }
    }
    
    /// Method to resize scroll view whenever a keyboard is present.
    @objc func keyboardWillHide(sender: NSNotification) {
        
        if !isKeyboardVisible {
            return
        }
        
        self.isKeyboardVisible = false
        
        let userInfo = sender.userInfo as! [String: AnyObject]
        
        var keyboardFrameValue = userInfo["UIKeyboardBoundsUserInfoKey"] as? NSValue
        if keyboardFrameValue == nil {
            keyboardFrameValue = userInfo["UIKeyboardFrameEndUserInfoKey"] as? NSValue
        }
        
        if keyboardFrameValue != nil {
            
            var animationDuration = 0.3
            if let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                animationDuration = duration
            }
            
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                
                self.scrollView.contentInset = UIEdgeInsets(
                    top: self.scrollView.contentInset.top,
                    left: self.scrollView.contentInset.left,
                    bottom: 0,
                    right: self.scrollView.contentInset.right
                )
                
                self.scrollView.scrollIndicatorInsets = UIEdgeInsets(
                    top: self.scrollView.scrollIndicatorInsets.top,
                    left: self.scrollView.scrollIndicatorInsets.left,
                    bottom: 0,
                    right: self.scrollView.scrollIndicatorInsets.right
                )
                
            }, completion: { (finished) -> Void in
                
                self.scrollView.setContentOffset(CGPoint.zero, animated: true)
            })
        }
    }
}
