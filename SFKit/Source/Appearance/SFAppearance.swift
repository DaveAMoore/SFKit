//
//  SFAppearance.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 7/1/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

/// Style of San Fransisco appearance design to actuate.
@objc
public enum SFAppearanceStyle: Int {
    case light
    case dark
}

/// San Fransisco is built upon a given set of guiding design principles. Such concepts are bound to change from time-to-time, thereby constituting the `SFAppearance` object.
/// The design of San Fransisco objects have been designed to all incorporate a unified look and feel. `SFAppearance` is the only supported method of customization on a global scale.
final public class SFAppearance: NSObject {
    
    // MARK: - Static Properties
    
    /// Global San Fransisco appearance for this process.
    public static var global = SFAppearance(.light)
    
    // MARK: - Properties
    
    /// Style of appearance in this object.
    public var appearanceStyle: SFAppearanceStyle {
        willSet {
            postChangeNotification(for: .SFAppearanceStyleWillChange, oldValue: appearanceStyle, newValue: newValue)
        } didSet {
            // Call the 'appearanceStyleDidChange(_:)' method on every environment currently registered.
            appearanceEnvironments.allObjects.forEach { $0.appearanceStyleDidChange(appearanceStyle) }
            postChangeNotification(for: .SFAppearanceStyleDidChange, oldValue: oldValue, newValue: appearanceStyle)
        }
    }
    
    /// Hash table which contains weak references to each appearance environment subscribed to recieve changes.
    private var appearanceEnvironments = NSHashTable<SFAppearanceEnvironment>.weakObjects()
    
    // MARK: - Initialization
    
    /// Creates a new `SFAppearance` object with a given style of appearance.
    ///
    /// - Parameter appearanceStyle: The appearance style for the new `SFAppearance` object.
    private init(_ appearanceStyle: SFAppearanceStyle) {
        // Setup the appearance style.
        self.appearanceStyle = appearanceStyle
        
        // Call super.
        super.init()
    }
    
    // MARK: - Appearance Environment Management
    
    /// <#Description#>
    ///
    /// - Parameter appearanceEnvironment: <#appearanceEnvironment description#>
    public func addAppearanceEnvironment(_ appearanceEnvironment: SFAppearanceEnvironment) {
        appearanceEnvironments.add(appearanceEnvironment)
    }
    
    // MARK: - Helper Methods
    
    /// Posts a change notification with the appropriate notification name, as determined by the caller.
    ///
    /// - Parameters:
    ///   - name: `Notification.Name` of the change notification that will be posted.
    ///   - oldValue: Value *A*.
    ///   - newValue: Value *B*.
    ///
    /// - Note: Value *A* will be compared to value *B*, and if they are different, a change notification will be posted to the default notification center.
    private func postChangeNotification(for name: Notification.Name, oldValue: SFAppearanceStyle, newValue: SFAppearanceStyle) {
        // Make sure the value did indeed change.
        guard oldValue != newValue else { return }
        
        // Create a notification for the appearance style changing.
        let changeNotification = Notification(name: name, object: self, userInfo: nil)
        
        // Post the change notification.
        NotificationCenter.default.post(changeNotification)
    }
}

// MARK: - Add SFAppearance Change Names
extension Notification.Name {
    
    public static let SFAppearanceStyleWillChange: NSNotification.Name = NSNotification.Name(rawValue: "SFAppearanceStyleWillChange")
    
    public static let SFAppearanceStyleDidChange: NSNotification.Name = NSNotification.Name(rawValue: "SFAppearanceStyleDidChange")
}
