//
//  SFVisualEffectView.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable
open class SFVisualEffectView: UIVisualEffectView {
    
    /// Boolean value indicating if the visual effect view uses an extra light blur effect.
    @IBInspectable open var isExtraLight: Bool = false
    
    // MARK: - Lifecycle
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        // Perform any additional setup here.
        
        // Register for any updates with regards to appearance.
        registerForAppearanceUpdates()
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        // Perform any additional setup here.
        
        // Register for any updates with regards to appearance.
        registerForAppearanceUpdates()
    }
    
    // MARK: - Update Methods
    
    open override func appearanceStyleDidChange(_ newAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(newAppearanceStyle)
        
        // Get a boolean value for the isLight property.
        let isLightAppearance = newAppearanceStyle == .light
        
        // Select the appropriate effect style.
        let effectStyle: UIBlurEffectStyle = isLightAppearance ? (isExtraLight ? .extraLight : .light) : .dark
        
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
