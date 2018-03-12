//
//  SFLabel.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

open class SFLabel: UILabel {
    
    open override var font: UIFont! {
        didSet {
            appearanceStyleDidChange(SFAppearance.global.style)
        }
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        registerForAppearanceUpdates()
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        registerForAppearanceUpdates()
    }
    
    open override func appearanceStyleDidChange(_ previousAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(previousAppearanceStyle)
        adjustsFontForContentSizeCategory = true
        if adjustsColorForAppearanceStyle {
            
        }
    }
}
