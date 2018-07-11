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
    
    // MARK: - Update Methods
    
    open override func appearanceStyleDidChange(_ previousAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(previousAppearanceStyle)
        
        // Get a boolean value for the isLight property.
        let isLightAppearance = appearance.style == .light
        
        // Select the appropriate effect style.
        let effectStyle: UIBlurEffect.Style = isLightAppearance ? (isExtraLight ? .extraLight : .light) : .dark
        
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
