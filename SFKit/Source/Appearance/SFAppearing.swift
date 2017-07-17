//
//  SFAppearing.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 7/1/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

/// A San Fransisco designed object will comply with this protocol in order to properly implement design principles.
public protocol SFAppearing: class {
    
    // MARK: - Properties
    
    /// Appearance of the designable object.
    var appearance: SFAppearance { get }
    
    /// Boolean value dictating the enforcability of the appearance.
    var shouldEnforceAppearance: Bool { get set }
    
    /// Unique `SFAppearance` style observation token.
    var appearanceStyleObserver: NSObjectProtocol? { get set }
    
    // MARK: - Update Methods
    
    /// Call this method when the appearance of an object must be updated for a new appearance set.
    ///
    /// - Parameter appearance: The appearance which will be updated to.
    func updateDesign(for appearance: SFAppearance)
}

extension SFAppearing {
    
    /// Registers the object for appearance style change notifications.
    ///
    /// - Returns: A unique observer token which conforms to the `NSObjectProtocol`. The observer token must be kept in memory and removed via `unregisterForAppearanceUpdates(with:)` before deallocation.
    public func registerForAppearanceUpdates() {
        // Update the appearance whenever this function is called.
        updateDesign(for: appearance)
        
        // Only register if it hasn't been registered already.
        guard appearanceStyleObserver == nil else { return }
        
        // Adds the closure as an observer of the notification.
        appearanceStyleObserver = NotificationCenter.default.addObserver(forName: .SFAppearanceStyleDidChange, object: nil, queue: .main) { notification in
            // Call to have the design updated.
            self.updateDesign(for: self.appearance)
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
