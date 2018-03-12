//
//  SFTextView.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 7/1/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable open class SFTextView: UITextView {
    
    // MARK: - Properties
    
    // MARK: - Inspectable Properties
    /// Boolean value determining whether or not the appearance will be forcefully applied.
    @available(*, deprecated, message: "use 'adjustsColorForAppearanceStyle' instead")
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
}
