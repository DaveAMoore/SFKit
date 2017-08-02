//
//  SFViewController.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

open class SFViewController: UIViewController, SFAppearanceStyleObserver {
    
    // MARK: - Setup
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Register for appearance updates.
        registerForAppearanceUpdates()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Perform additional deconstruction here.
        
        // Unregister from updates regarding changes.
        unregisterForAppearanceUpdates()
    }
    
    // MARK: - Update Methods
    
    open func appearanceStyleDidChange(_ notification: Notification) {
        // Make sure to update the status bar.
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        let isLightAppearance = SFAppearance.global.appearanceStyle == .light
        return isLightAppearance ? .default : .lightContent
    }
}
