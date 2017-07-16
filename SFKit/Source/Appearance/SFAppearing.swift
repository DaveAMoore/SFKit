//
//  SFAppearing.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 7/1/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

/// A San Fransisco designed object will comply with this protocol in order to properly implement design principles.
public protocol SFAppearing: NSObjectProtocol {
    
    // MARK: - Properties
    
    /// Appearance of the designable object.
    var appearance: SFAppearance { get set }
    
    /// Boolean value dictating the enforcability of the appearance.
    var shouldEnforceAppearance: Bool { get set }
    
    // MARK: - Update Methods
    
    /// Call this method when the appearance of an object must be updated for a new appearance set.
    ///
    /// - Parameter appearance: The appearance which will be updated to.
    func updateDesign(for appearance: SFAppearance)
}
