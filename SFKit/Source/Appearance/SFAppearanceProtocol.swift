//
//  SFAppearanceProtocol.swift
//  SFKit
//
//  Created by David Moore on 7/17/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@objc public protocol SFAppearanceProtocol: SFAppearanceStyleObserver {
    
    // MARK: - Properties
    
    @objc optional var appearance: SFAppearance { get set }
    
    /// Boolean value dictating the enforcability of the appearance.
    var shouldEnforceAppearance: Bool { get set }
}
