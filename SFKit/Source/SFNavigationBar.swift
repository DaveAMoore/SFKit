//
//  SFNavigationBar.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

public class SFNavigationBar: UINavigationBar, SFAppearanceStyleObserver {
    
    // MARK: - Setup
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        // Perform any additional setup here.
        
        // Register for appearance updates.
        registerForAppearanceUpdates()
    }
    
    public override func removeFromSuperview() {
        super.removeFromSuperview()
        // Perform any additional deconstruction here.
        
        // Unregister from updates regarding changes.
        unregisterForAppearanceUpdates()
    }
    
    // MARK: - Appearance
    
    /// This method is called whenever the appearance an object is correlated to, changes.
    ///
    /// - Parameter notification: The notification that caused the method to be called.
    public func appearanceStyleDidChange(_ notification: Notification) {
        // Get the new appearance from the notification.
        let newAppearance = retrieveAppearance(for: notification)
        
        // Change the bar style for the new appearance style.
        barStyle = newAppearance.appearanceStyle == .light ? .default : .black
    }
}
