//
//  UIViewController+IFACoreUI.swift
//  IFACoreUI
//
//  Created by Marcelo Schroeder on 15/8/17.
//  Copyright © 2017 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation
import UIKit

private var AssociatedObjectHandleTypedNotificationObservers: UInt8 = 0

extension UIViewController {
    
    /// Any typed notification observers added to this array will be removed automatically on deinit.
    public var ifa_typedNotificationObservers: [TypedNotificationObserver] {
        get {
            var obj = objc_getAssociatedObject(self, &AssociatedObjectHandleTypedNotificationObservers) as? Array<TypedNotificationObserver>
            if obj == nil {
                obj = []
                self.ifa_typedNotificationObservers = obj!
            }
            return obj!
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandleTypedNotificationObservers, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
