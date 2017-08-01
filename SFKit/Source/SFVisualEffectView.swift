//
//  SFVisualEffectView.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable
public class SFVisualEffectView: UIVisualEffectView, SFAppearanceProtocol {
    
    // MARK: - Properties
    
    @IBInspectable
    public var shouldEnforceAppearance: Bool = false
    
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
    
    // MARK: - Update Methods
    
    /// This method is called whenever the appearance an object is correlated to, changes.
    ///
    /// - Parameter notification: The notification that caused the method to be called.
    public func appearanceStyleDidChange(_ notification: Notification) {
        guard shouldEnforceAppearance else { return }
        
        // Get the notification's appearance value.
        let newAppearance = retrieveAppearance(for: notification)
        
        // Get a boolean value for the isLight property.
        let isLightAppearance = newAppearance.appearanceStyle == .light
        
        // Select the appropriate effect style.
        let effectStyle: UIBlurEffectStyle = isLightAppearance ? .extraLight : .dark
        
        // Make a blur effect for the newly determined style.
        let blurEffect = UIBlurEffect(style: effectStyle)
        
        // Only change the effect if it is a blur effect.
        if effect is UIBlurEffect {
            // Change the effect style.
            effect = blurEffect
        } else if effect is UIVibrancyEffect {
            // Update the vibrancy effect for the new blur effect.
            effect = UIVibrancyEffect(blurEffect: blurEffect)
        }
    }
}
