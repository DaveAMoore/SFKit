//
//  SFAppearance.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 7/1/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

/// San Fransisco is built upon a given set of guiding design principles. Such concepts are bound to change from time-to-time, thereby constituting the `SFAppearance` object.
/// The design of San Fransisco objects have been designed to all incorporate a unified look and feel. `SFAppearance` is the only supported method of customization on a global scale.
final public class SFAppearance: NSObject {
    
    // MARK: - SFAppearance.Style Declaration
    
    /// Style of San Fransisco appearance design to actuate.
    public enum Style: Int {
        case regular
    }
    
    // MARK: - Static Properties
    
    /// Global San Fransisco appearance for this process.
    public static var global = SFAppearance(.regular)
    
    // MARK: - Properties
    
    /// Style of appearance in this object.
    public var appearanceStyle: Style
    
    // MARK: - Initialization
    
    /// Creates a new `SFAppearance` object with a given style of appearance.
    ///
    /// - Parameter appearanceStyle: The appearance style for the new `SFAppearance` object.
    public init(_ appearanceStyle: Style) {
        // Setup the appearance style.
        self.appearanceStyle = appearanceStyle
        
        // Call super.
        super.init()
    }
    
}
