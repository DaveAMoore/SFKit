//
//  SFTextField.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable
open class SFTextField: UITextField, UITextFieldDelegate {
    
    // MARK: - Properties
    
    /// Edge insets of the content size for the receiver.
    open var contentInsets: UIEdgeInsets = .zero
    
    // MARK: - Lifecycle
    
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
        // Apply additional appearance adjustments here.
        
        // Configure the appearance.
        let colorMetrics = UIColorMetrics(forAppearance: appearance)
        layer.cornerRadius = 11
        contentInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        adjustsFontForContentSizeCategory = true
        keyboardAppearance = appearance.style == .light ? .light : .dark
        
        // Get the appropriate system font.
        let mediumFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        // Use font metrics for iOS 11 and up.
        if #available(iOS 11.0, *) {
            font = UIFontMetrics.default.scaledFont(for: mediumFont)
        } else {
            font = mediumFont
        }
        
        // Update background color.
        backgroundColor = colorMetrics.color(forRelativeHue: .extraLightGray)
        textColor = colorMetrics.color(forRelativeHue: .black)
    }
    
    // MARK: - Appearance Adjustment
    
    open override var placeholder: String? {
        didSet {
            guard let placeholder = placeholder else { return }
            
            // Create an attributed placeholder and set it.
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColorMetrics(forAppearance: appearance).color(forRelativeHue: .extraLightGray)])
            self.attributedPlaceholder = attributedPlaceholder
        }
    }
    
    // MARK: - Delegate
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        // Create a mutable copy.
        var bounds = bounds
        
        // Apply the transformations.
        
        bounds.origin.x += contentInsets.left
        bounds.size.width -= contentInsets.left
        
        bounds.origin.y += contentInsets.top
        bounds.size.height -= contentInsets.top
        
        bounds.size.width -= contentInsets.right
        bounds.size.height -= contentInsets.bottom
        
        return bounds
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
