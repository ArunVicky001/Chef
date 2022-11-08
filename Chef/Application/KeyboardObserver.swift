//
//  KeyboardObserver.swift
//  SuperTeacher
//
//  Created by Hamza Ansari on 06/10/20.
//  Copyright © 2020 Toppr. All rights reserved.
//

import UIKit

public final class UnderKeyboardObserver: NSObject {
    public typealias AnimationCallback = (_ height: CGFloat) -> Void
    
    let notificationCenter: NotificationCenter
    
    /// Function that will be called before the keyboard is shown and before animation is started.
    public var willAnimateKeyboard: AnimationCallback?
    
    /// Function that will be called inside the animation block. This can be used to call `layoutIfNeeded` on the view.
    public var animateKeyboard: AnimationCallback?
    
    /// Current height of the keyboard. Has value `nil` if unknown.
    public var currentKeyboardHeight: CGFloat?
    
    /// Creates an instance of the class
    public override init() {
        notificationCenter = NotificationCenter.default
        super.init()
    }
    
    deinit {
        stop()
    }
    
    /// Start listening for keyboard notifications.
    public func start() {
        stop()
        
        notificationCenter.addObserver(self, selector: #selector(UnderKeyboardObserver.keyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(UnderKeyboardObserver.keyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Stop listening for keyboard notifications.
    public func stop() {
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notification
    
    @objc func keyboardNotification(_ notification: Foundation.Notification) {
        let isShowing = notification.name == UIResponder.keyboardWillShowNotification
        
        if let userInfo = (notification as Foundation.Notification).userInfo,
            let height = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height,
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            
            let correctedHeight = isShowing ? height : 0
            willAnimateKeyboard?(correctedHeight)
            
            UIView.animate(withDuration: duration,
                                       delay: TimeInterval(0),
                                       options: UIView.AnimationOptions(rawValue: animationCurveRawNSN.uintValue),
                                       animations: { [weak self] in
                                        self?.animateKeyboard?(correctedHeight)
                },
                                       completion: nil
            )
            
            currentKeyboardHeight = correctedHeight
        }
    }
}
