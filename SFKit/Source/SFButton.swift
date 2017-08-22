//
//  SFButton.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 6/29/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable open class SFButton: UIButton {
    
    // MARK: - Style Enum -
    
    @objc public enum Kind: Int {
        case square
        case rounded
    }
    
    // MARK: - Properties
    
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
            // isElliptical = layer.cornerRadius == ellipticalCornerRadius(for: oldValue)
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
            } else {
                backgroundColor = SFColor.lightGray
            }
        }
    }
    
    open override var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
            
            // Cache the background color, just in case.
            cacheBackgroundColor(isEnabled: isEnabled, isHighlighted: isHighlighted, isSelected: oldValue)
            
            if isSelected {
                backgroundColor = cachedBackgroundColor?.withAlphaComponent(0.5)
                /*
                backgroundColor = cachedBackgroundColor! - 0.1
                layer.borderColor = cachedBackgroundColor?.cgColor
                layer.borderWidth = 2.0
                setTitleColor(cachedBackgroundColor, for: .highlighted)*/
            } else {
                backgroundColor = cachedBackgroundColor
                layer.borderColor = SFColor.clear.cgColor
                setTitleColor(SFColor.white, for: .normal)
            }
        }
    }
    
    open override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            
            // Cache the background color, just in case.
            cacheBackgroundColor(isEnabled: isEnabled, isHighlighted: oldValue, isSelected: isSelected)
            
            // Adjust as needed.
            if isHighlighted {
                backgroundColor = SFColor.clear
                layer.borderColor = cachedBackgroundColor?.cgColor
                layer.borderWidth = 3.0
                setTitleColor(cachedBackgroundColor, for: .normal)
            } else {
                backgroundColor = cachedBackgroundColor
                layer.borderColor = SFColor.clear.cgColor
                setTitleColor(SFColor.white, for: .normal)
            }
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
        
        // The button defaults to be elliptical in presentation.
        // isElliptical = true
        
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
            
            // Rounded corner radius.
            cornerRadius = ellipticalCornerRadius(for: frame)
            
            // Smaller content edge insets.
            contentEdgeInsets = UIEdgeInsets(top: 7.2, left: 13.4, bottom: 7.2, right: 13.4)
        case .square:
            // Use UIFontMetrics for a more custom look, but that only works on iOS 11 and later.
            if #available(iOS 11.0, *) {
                font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .bold))
            } else {
                font = UIFont.preferredFont(forTextStyle: .headline)
            }
            
            // Square corner radius.
            cornerRadius = 8
            
            // Large edge insets for the square style.
            //contentEdgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 17, right: 0)
            
            // heightAnchor.constraint(equalToConstant: 50).isActive = true
            // widthAnchor.constraint(equalToConstant: 288).isActive = true
        }
        
        // Set the font.
        titleLabel?.font = font
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
