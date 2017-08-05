//
//  SFViewController.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

open class SFViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register for appearance updates.
        registerForAppearanceUpdates()
    }
    
    open override func appearanceStyleDidChange(_ newAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(newAppearanceStyle)
        
        // Make sure to update the status bar.
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        let isLightAppearance = appearance.appearanceStyle == .light
        return isLightAppearance ? .default : .lightContent
    }
}
