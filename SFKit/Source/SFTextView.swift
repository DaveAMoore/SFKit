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
    public let appearance: SFAppearance = .global
    
    /// Unique `SFAppearance` style observation token.
    public var appearanceStyleObserver: NSObjectProtocol?
    
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
        
        // Register for any updates with regards to appearance.
        registerForAppearanceUpdates()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Register for any updates with regards to appearance.
        registerForAppearanceUpdates()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        // Register for any updates with regards to appearance.
        registerForAppearanceUpdates()
    }
    
    // MARK: - Appearance Updating
    
    public func updateDesign(for appearance: SFAppearance) {
        // Prevent asserting the defaults if the default design shall not be enforced.
        guard shouldEnforceAppearance else { return }
        
        // Set the default values.
        cornerRadius = 16.0
        
        // Set the default background and text colors.
        backgroundColor = SFColor.primary
        textColor = SFColor.contrastive
    }
}
