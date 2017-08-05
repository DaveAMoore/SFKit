//
//  SFNavigationBar.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

open class SFNavigationBar: UINavigationBar {
    
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
    
    open override func appearanceStyleDidChange(_ newAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(newAppearanceStyle)
        
        // Change the bar style for the new appearance style.
        barStyle = newAppearanceStyle == .light ? .default : .black
        tintColor = SFColor.blue
    }
}
