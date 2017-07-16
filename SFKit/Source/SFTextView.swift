//
//  SFTextView.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 7/1/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable public final class SFTextView: UITextView, SFAppearing {
    
    // MARK: - Properties
    
    /// The appearance of the text view.
    public var appearance: SFAppearance = .global
    
    // MARK: - Inspectable Properties
    /// Boolean value determining whether or not the appearance will be forcefully applied.
    @IBInspectable public var shouldEnforceAppearance: Bool = true
    
    /// Corner radius of the text view.
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    /// Edge inset for the top of the embedded text container.
    @IBInspectable public var topTextContainerInset: CGFloat {
        get {
            return textContainerInset.top
        } set {
            textContainerInset.top = newValue
        }
    }
    
    /// Edge inset for the bottom of the embedded text container.
    @IBInspectable public var bottomTextContainerInset: CGFloat {
        get {
            return textContainerInset.bottom
        } set {
            textContainerInset.bottom = newValue
        }
    }
    
    /// Edge inset for the left of the embedded text container.
    @IBInspectable public var leftTextContainerInset: CGFloat {
        get {
            return textContainerInset.left
        } set {
            textContainerInset.left = newValue
        }
    }
    
    /// Edge inset for the right of the embedded text container.
    @IBInspectable public var rightTextContainerInset: CGFloat {
        get {
            return textContainerInset.right
        } set {
            textContainerInset.right = newValue
        }
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        // Make sure the default values are setup.
        updateDesign(for: appearance)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Make sure the default values are setup.
        updateDesign(for: appearance)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        // Make sure the default values are setup.
        updateDesign(for: appearance)
    }
    
    // MARK: - Appearance Updating
    
    public func updateDesign(for appearance: SFAppearance) {
        // Prevent asserting the defaults if the default design shall not be enforced.
        guard shouldEnforceAppearance else { return }
        
        // Set the default values.
        cornerRadius = 16.0
        
        // Set the default background and text colors.
        backgroundColor = SFColor.white
        textColor = SFColor.black
    }
}
