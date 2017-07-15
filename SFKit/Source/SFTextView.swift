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
    public private(set) var appearance: SFAppearance<SFTextView> = .global()
    
    /// Corner radius of the text view.
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return appearance.attribute(forKeyPath: \SFTextView.cornerRadius) ?? 16.0
            // return layer.cornerRadius
        } set {
            appearance.setAttribute(newValue, forKeyPath: \SFTextView.cornerRadius)
            // layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var topTextContainerInset: CGFloat {
        get {
            return appearance.attribute(forKeyPath: \SFTextView.topTextContainerInset) ?? 0.0
            // return textContainerInset.top
        } set {
            appearance.setAttribute(newValue, forKeyPath: \SFTextView.topTextContainerInset)
            textContainerInset.top = newValue
        }
    }
    
    @IBInspectable public var bottomTextContainerInset: CGFloat {
        get {
            return appearance.attribute(forKeyPath: \SFTextView.bottomTextContainerInset) ?? 0.0
            // return textContainerInset.bottom
        } set {
            appearance.setAttribute(newValue, forKeyPath: \SFTextView.bottomTextContainerInset)
            textContainerInset.bottom = newValue
        }
    }
    
    @IBInspectable public var leftTextContainerInset: CGFloat {
        get {
            return appearance.attribute(forKeyPath: \SFTextView.leftTextContainerInset) ?? 0.0
            // return textContainerInset.left
        } set {
            appearance.setAttribute(newValue, forKeyPath: \SFTextView.leftTextContainerInset)
            textContainerInset.left = newValue
        }
    }
    
    @IBInspectable public var rightTextContainerInset: CGFloat {
        get {
            return appearance.attribute(forKeyPath: \SFTextView.rightTextContainerInset) ?? 0.0
            // return textContainerInset.right
        } set {
            appearance.setAttribute(newValue, forKeyPath: \SFTextView.rightTextContainerInset)
            textContainerInset.right = newValue
        }
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        updateAppearance()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        updateAppearance()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        // Make sure the default values are setup.
        updateAppearance()
    }
    
    // MARK: - Methods
    
    public static func setDefaults(for appearance: SFAppearance<SFTextView>) {
        appearance.setAttribute(UIColor.black, forKeyPath: \SFTextView.backgroundColor)
    }
    
    public func setAppearance(to newAppearance: SFAppearance<SFTextView>) {
        self.appearance = newAppearance
    }
    
    func updateAppearance() {
        // Set the default values.
        cornerRadius = 16.0
        
        // Set the default background and text colors.
        backgroundColor = SFColor.white
        textColor = SFColor.black
    }
}
