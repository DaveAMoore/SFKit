//
//  SFAppearanceProtocol.swift
//  SFKit
//
//  Created by David Moore on 7/17/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

public protocol SFAppearanceProtocol: SFAppearanceStyleObserver {
    
    // MARK: - Properties
    
    /// Appearance of the designable object.
    var appearance: SFAppearance { get }
    
    /// Boolean value dictating the enforcability of the appearance.
    var shouldEnforceAppearance: Bool { get set }
}
