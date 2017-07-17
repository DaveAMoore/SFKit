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
    
    /// Unique `SFAppearance` style observation token.
    var appearanceStyleObserver: NSObjectProtocol? { get set }
    
    // MARK: - Update Methods
    
    /// Call this method when the appearance of an object must be updated for a new appearance set.
    ///
    /// - Parameter appearance: The appearance which will be updated to.
    func updateDesign(for appearance: SFAppearance)
}
