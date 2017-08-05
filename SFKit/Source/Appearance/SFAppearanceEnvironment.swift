//
//  SFAppearanceEnvironment.swift
//  SFKit
//
//  Created by David Moore on 8/4/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@objc public protocol SFAppearanceEnvironment: NSObjectProtocol {
    
    @objc var appearance: SFAppearance { get }
    
    @objc func appearanceStyleDidChange(_ newAppearanceStyle: SFAppearanceStyle)
}

extension SFAppearanceEnvironment {
    
    public var appearance: SFAppearance {
        // Get the global appearance.
        let globalAppearance = SFAppearance.global
        
        // Add ourselves as an appearance environment.
        globalAppearance.addAppearanceEnvironment(self)
        
        return globalAppearance
    }
}
