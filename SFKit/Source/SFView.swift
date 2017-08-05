//
//  SFView.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable open class SFView: UIView {
    
    // MARK: - Properties
    
    @IBInspectable open var shouldEnforceAppearance: Bool = false
    
    /// Corner radius of the view.
    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
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
        
        backgroundColor = SFColor.white
    }
}
