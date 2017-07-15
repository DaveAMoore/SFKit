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
    var appearance: SFAppearance { get }
    
    // MARK: - Update Methods
    
    func setAppearance(to newAppearance: SFAppearance<Self>)
    
    static func setDefaults(for appearance: SFAppearance<Self>)
    
    // func appearanceDidUpdate(_ appearance: SFAppearance)
}
