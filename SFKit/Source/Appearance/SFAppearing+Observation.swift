//
//  SFAppearing+Observation.swift
//  SFKit
//
//  Created by David Moore on 7/17/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

extension SFAppearing {
    
    /// Registers the object for appearance style change notifications.
    ///
    /// - Returns: A unique observer token which conforms to the `NSObjectProtocol`. The observer token must be kept in memory and removed via `unregisterForAppearanceUpdates(with:)` before deallocation.
    public func registerForAppearanceUpdates() {
        registerForAppearanceUpdates(with: .global)
    }
    
    /// Registers the receiver for updates to the appearance style. This call must be paired with a call to `unregisterForAppearanceUpdates()` when updates are no longer desired, or before `deinit`.
    ///
    /// - Parameter appearance: Appearance which will be observed for `SFAppearance.Style` changes.
    fileprivate func registerForAppearanceUpdates(with appearance: SFAppearance) {
        // Update the appearance whenever this function is called.
        updateDesign(for: appearance)
        
        // Only register if it hasn't been registered already.
        guard appearanceStyleObserver == nil else { return }
        
        // Adds the closure as an observer of the notification.
        appearanceStyleObserver = NotificationCenter.default.addObserver(forName: .SFAppearanceStyleDidChange, object: nil, queue: .main) { notification in
            // Call to have the design updated.
            self.updateDesign(for: appearance)
        }
    }
    
    /// Unregisters for appearance style change updates.
    ///
    /// - Parameter appearanceChangeObserver: The unique observer token returned when appearance updates were registered for.
    public func unregisterForAppearanceUpdates() {
        // Optionally unwrap the appearance style observation token, so we only unregister if its already registered.
        if let appearanceChangeObserver = appearanceStyleObserver {
            // Remove the observer token from the notification center's queue.
            NotificationCenter.default.removeObserver(appearanceChangeObserver)
            
            // Nullify the observer to ensure release.
            self.appearanceStyleObserver = nil
        }
    }
}

extension SFAppearanceProtocol {
    
    /// Registers the object for appearance style change notifications.
    ///
    /// - Returns: A unique observer token which conforms to the `NSObjectProtocol`. The observer token must be kept in memory and removed via `unregisterForAppearanceUpdates(with:)` before deallocation.
    public func registerForAppearanceUpdates() {
        registerForAppearanceUpdates(with: appearance)
    }
}
