//
//  SFButton.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 6/29/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

extension SFColor {
    /// Rich outlining blue which can be used to clarify an interactive object. This should be used to outline objects with the `SFColor.blue` color.
    fileprivate static var darkBlue: SFColor {
        return .blue - 0.075
    }
}

@IBDesignable open class SFButton: UIButton {
    
    // MARK: - Style Enum -
    
    @objc public enum Kind: Int {
        case square
        case rounded
    }
    
    // MARK: - Properties
    
    /// Border width for the `SFButton` as it is resting.
    private var restingBorderWidth: CGFloat = 0.0
    
    /// Cached background color that is used for selection and enabling.
    private var cachedBackgroundColor: SFColor?
    
    /// The corner radius of the button.
    private var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    /// The kind of button that will be displayed.
    open var buttonKind: Kind = .square {
        didSet {
            appearanceStyleDidChange(appearance.appearanceStyle)
        }
    }
    
    // MARK: - Inspectable Properties
    
    @IBInspectable open var buttonKindRawValue: Int {
        get {
            return buttonKind.rawValue
        } set {
            buttonKind = Kind(rawValue: newValue) ?? .square
        }
    }
    
    /// Boolean value indicating if the corner radius of the button is equal to the halving of the minimal dimension (width or height).
    @available(iOS, deprecated: 10.0, message: "use 'buttonKind' instead")
    open var isElliptical: Bool {
        get {
            return layer.cornerRadius == ellipticalCornerRadius(for: frame)
        } set {
            if newValue {
                layer.cornerRadius = ellipticalCornerRadius(for: frame)
            } else {
                layer.cornerRadius = 0.0
            }
        }
    }
    
    // MARK: - Managed Properties
    
    /// Frame must be overriden to ensure the elliptical boolean remains equivalent.
    open override var frame: CGRect {
        didSet {
            appearanceStyleDidChange(appearance.appearanceStyle)
        }
    }
    
    open override var isEnabled: Bool {
        didSet {
            guard isEnabled != oldValue else { return }
            
            // Cache the background color.
            cacheBackgroundColor(isEnabled: oldValue, isHighlighted: isHighlighted, isSelected: isSelected)
            
            // Adjust the background color as needed.
            if isEnabled {
                backgroundColor = cachedBackgroundColor
                layer.borderWidth = restingBorderWidth
            } else {
                backgroundColor = SFColor.lightGray
                layer.borderWidth = 0.0
            }
        }
    }
    
    open override var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
            
            // Cache the background color, just in case.
            cacheBackgroundColor(isEnabled: isEnabled, isHighlighted: isHighlighted, isSelected: oldValue)
            
            if isSelected {
                layer.borderWidth = 0.0
                backgroundColor = cachedBackgroundColor?.withAlphaComponent(0.5)
                /*
                backgroundColor = cachedBackgroundColor! - 0.1
                layer.borderColor = cachedBackgroundColor?.cgColor
                layer.borderWidth = 2.0
                setTitleColor(cachedBackgroundColor, for: .highlighted)*/
            } else {
                backgroundColor = cachedBackgroundColor
                layer.borderColor = SFColor.darkBlue.cgColor
                layer.borderWidth = restingBorderWidth
                setTitleColor(SFColor.white, for: .normal)
            }
        }
    }
    
    open override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            
            // Cache the background color, just in case.
            cacheBackgroundColor(isEnabled: isEnabled, isHighlighted: oldValue, isSelected: isSelected)
            
            // Declare the background and title colors.
            let backgroundColor: UIColor?
            let titleColor: UIColor?
            
            // Adjust as needed.
            if isHighlighted {
                backgroundColor = SFColor.clear
                titleColor = cachedBackgroundColor
                layer.borderColor = cachedBackgroundColor?.cgColor
                layer.borderWidth = 3.0
            } else {
                backgroundColor = cachedBackgroundColor
                titleColor = SFColor.white
                layer.borderColor = SFColor.darkBlue.cgColor
                layer.borderWidth = restingBorderWidth
            }
            
            // Cancel any previous transitions.
            layer.removeAllAnimations()
            
            // Start the transition.
            UIView.transition(with: self, duration: 0.2, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
                self.backgroundColor = backgroundColor
                self.setTitleColor(titleColor, for: .normal)
            }, completion: nil)
        }
    }
    
    // MARK: - Initialization
    
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
        
        // Set a San Fransisco blue color as the background color.
        backgroundColor = SFColor.blue
        
        // Set the title color to our San Fransisco white.
        setTitleColor(SFColor.white, for: .normal)
        
        // Enable automatic dynamic type adjustment.
        titleLabel?.adjustsFontForContentSizeCategory = true
        
        // Declare the font.
        let font: UIFont
        
        // Switch on the kind of button we are making.
        switch buttonKind {
        case .rounded:
            // Use UIFontMetrics for a more custom look, but that only works on iOS 11 and later.
            if #available(iOS 11.0, *) {
                font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .semibold))
            } else {
                font = UIFont.preferredFont(forTextStyle: .headline)
            }
            
            // There is no border for the rounded button style.
            restingBorderWidth = 0.0
            
            // Rounded corner radius.
            cornerRadius = ellipticalCornerRadius(for: frame)
            
            // Smaller content edge insets.
            contentEdgeInsets = UIEdgeInsets(top: 7.2, left: 13.4, bottom: 7.2, right: 13.4)
        case .square:
            // Use UIFontMetrics for a more custom look, but that only works on iOS 11 and later.
            if #available(iOS 11.0, *) {
                font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .medium))
            } else {
                font = UIFont.preferredFont(forTextStyle: .headline)
            }
            
            // Set the resting border width.
            restingBorderWidth = 1.5
            
            // Square corner radius.
            cornerRadius = 12
            
            // Large edge insets for the square style.
            contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
        }
        
        // Set the font.
        titleLabel?.font = font
        
        // Set the border color and width.
        layer.borderColor = SFColor.darkBlue.cgColor
        layer.borderWidth = restingBorderWidth
    }
    
    // MARK: - Helper Methods
    
    /// Generates an elliptical corner radius value.
    ///
    /// - Returns: `CGFloat` value representing the floored value of the minimal dimension divided by two (half the dimension), represents the corner radius for an elliptical (pill-shaped) button.
    private func ellipticalCornerRadius(for rect: CGRect) -> CGFloat {
        return floor(min(rect.width, rect.height) / 2)
    }
    
    /// Caches the background color if required.
    ///
    /// - Parameter oldValue: The last value of the property which is calling this caching method.
    private func cacheBackgroundColor(isEnabled: Bool, isHighlighted: Bool, isSelected: Bool) {
        // Cache the background color only if the old value was true.
        if isEnabled, !isHighlighted, !isSelected {
            cachedBackgroundColor = backgroundColor == nil ? nil : SFColor(uiColor: backgroundColor!)
        }
    }
}
