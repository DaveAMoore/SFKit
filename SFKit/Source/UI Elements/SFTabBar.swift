//
//  SFTabBar.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

open class SFTabBar: UITabBar {
    
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
    
    open override func appearanceStyleDidChange(_ previousAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(previousAppearanceStyle)
        
        // Update the bar style for the appearance style.
        barStyle = appearance.style == .light ? .default : .black
        tintColor = UIColorMetrics(forAppearance: appearance).color(forRelativeHue: .blue)
    }
}
