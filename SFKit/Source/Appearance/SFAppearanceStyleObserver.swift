//
//  SFAppearanceStyleObserver.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 7/1/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

/// A San Fransisco designed object will comply with this protocol in order to properly implement design principles.
@available(iOS, deprecated: 10.0, message: "use 'SFAppearanceEnvironment' instead")
@objc public protocol SFAppearanceStyleObserver: NSObjectProtocol {
    
    // MARK: - Update Methods
    
    /// This method is called whenever the appearance an object is correlated to, changes.
    ///
    /// - Parameter notification: The notification that caused the method to be called.
    @objc func appearanceStyleDidChange(_ notification: Notification)
}

@available(iOS, deprecated: 10.0, message: "use 'SFAppearanceEnvironment' instead")
extension SFAppearanceStyleObserver {
    
    /// Pulls the `SFAppearance` value from a given `Notification`.
    ///
    /// - Parameter notification: The notification which was provided by `appearanceStyleDidChange(_:)`.
    /// - Returns: `SFAppearance` for which the notification was fired in response to changing.
    public func retrieveAppearance(for notification: Notification) -> SFAppearance {
        return notification.object as! SFAppearance
    }
}

@available(iOS, deprecated: 10.0, message: "use 'SFAppearanceEnvironment' instead")
extension SFAppearanceStyleObserver {
    
    /// Registers the object for appearance style change notifications.
    public func registerForAppearanceUpdates() {
        registerForAppearanceUpdates(with: .global)
    }
    
    /// Registers the receiver for updates to the appearance style. This call must be paired with a call to `unregisterForAppearanceUpdates()` when updates are no longer desired, or before `deinit`.
    ///
    /// - Parameter appearance: Appearance which will be observed for `SFAppearance.Style` changes.
    fileprivate func registerForAppearanceUpdates(with appearance: SFAppearance) {
        // Update the appearance whenever this function is called.
        let mockNotification = Notification(name: .SFAppearanceStyleDidChange,
                                            object: appearance, userInfo: nil)
        appearanceStyleDidChange(mockNotification)
        
        // Register ourselves as the observer of the 'didChange' notification.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appearanceStyleDidChange(_:)),
                                               name: .SFAppearanceStyleDidChange, object: appearance)
    }
    
    /// Unregisters for appearance style change updates.
    public func unregisterForAppearanceUpdates() {
        unregisterForAppearanceUpdates(with: .global)
    }
    
    /// Unregisters for appearance style change updates.
    ///
    /// - Parameter appearanceChangeObserver: The unique observer token returned when appearance updates were registered for.
    fileprivate func unregisterForAppearanceUpdates(with appearance: SFAppearance) {
        // Remove ourselves as the observer for notifications with this appearance as the object.
        NotificationCenter.default.removeObserver(self, name: .SFAppearanceStyleDidChange, object: appearance)
    }
}

@available(iOS, deprecated: 10.0, message: "use 'SFAppearanceEnvironment' instead")
extension SFAppearanceProtocol where Self: NSObject {
    
    /// Registers the object for appearance style change notifications.
    ///
    /// - Returns: A unique observer token which conforms to the `NSObjectProtocol`. The observer token must be kept in memory and removed via `unregisterForAppearanceUpdates(with:)` before deallocation.
    public func registerForAppearanceUpdates() {
        if shouldEnforceAppearance {
            registerForAppearanceUpdates(with: appearance ?? .global)
        }
    }
}
