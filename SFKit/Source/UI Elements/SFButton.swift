//
//  SFButton.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 6/29/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@available(*, deprecated, message: "use UIColorMetrics instead")
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
    @available(*, deprecated, message: "use SFColor class properties instead")
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
            appearanceStyleDidChange(appearance.style)
        }
    }
    
    open override var tintColor: UIColor! {
        didSet {
            // print("Color did set.")
            
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
    @available(*, deprecated, message: "use 'buttonKind' instead")
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
            appearanceStyleDidChange(appearance.style)
        }
    }
    
    open override var isEnabled: Bool {
        didSet {
            updateIsEnabled()
        }
    }
    
    open override var isSelected: Bool {
        didSet {
            updateIsSelected()
        }
    }
    
    open override var isHighlighted: Bool {
        didSet {
            updateIsHighlighted()
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
    
    open override func appearanceStyleDidChange(_ previousAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(previousAppearanceStyle)
        
        // Configure the appearance.
        let colorMetrics = UIColorMetrics(forAppearance: appearance)
        backgroundColor = colorMetrics.color(forRelativeHue: .blue)
        setTitleColor(colorMetrics.color(forRelativeHue: .white), for: .normal)
        titleLabel?.adjustsFontForContentSizeCategory = true
        tintColor = colorMetrics.color(forRelativeHue: .white)
        
        // Set the border color and width.
        layer.borderColor = colorMetrics.color(forRelativeHue: .darkBlue).cgColor
        layer.borderWidth = restingBorderWidth
        layer.allowsEdgeAntialiasing = true
        
        // Update the appearance.
        updateButtonKind()
        updateIsSelected()
        updateIsHighlighted()
        updateIsEnabled()
    }
    
    // MARK: - Appearance
    
    /// Updates the appearance of the button for the `Kind`.
    private func updateButtonKind() {
        // Declare the font.
        let font: UIFont
        
        // Switch on the kind of button we are making.
        switch buttonKind {
        case .rounded:
            // Use UIFontMetrics for a more custom look, but that only works on iOS 11 and later.
            if #available(iOS 11.0, *) {
                font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .medium))
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
            restingBorderWidth = 0.25
            
            // Square corner radius.
            cornerRadius = 12
            
            // Large edge insets for the square style.
            contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
        }
        
        // Set the font.
        titleLabel?.font = font
    }
    
    /// Updates appearance for `isEnabled`.
    private func updateIsEnabled() {
        // Adjust the background color as needed.
        let colorMetrics = UIColorMetrics(forAppearance: appearance)
        if isEnabled {
            backgroundColor = colorMetrics.color(forRelativeHue: .blue)
            layer.borderWidth = restingBorderWidth
            tintColor = colorMetrics.color(forRelativeHue: .white)
        } else {
            backgroundColor = colorMetrics.color(forRelativeHue: .lightGray)
            layer.borderWidth = 0.0
            tintColor = colorMetrics.color(forRelativeHue: .gray)
        }
    }
    
    /// Updates the appearance of the receiver for the `isSelected` property.
    private func updateIsSelected() {
        let colorMetrics = UIColorMetrics(forAppearance: appearance)
        if isSelected {
            layer.borderWidth = 0.0
            backgroundColor = colorMetrics.color(forRelativeHue: .blue).withAlphaComponent(0.5)
            tintColor = colorMetrics.color(forRelativeHue: .white)
        } else {
            backgroundColor = colorMetrics.color(forRelativeHue: .blue)
            setTitleColor(colorMetrics.color(forRelativeHue: .white), for: .normal)
            layer.borderColor = colorMetrics.color(forRelativeHue: .darkBlue).cgColor
            layer.borderWidth = restingBorderWidth
            tintColor = colorMetrics.color(forRelativeHue: .white)
            self.alpha = 1.0
        }
    }
    
    /// Update the appearance for `isHighlighted`.
    private func updateIsHighlighted() {
        guard !isSelected else { return }
        
        // Adjust as needed.
        let colorMetrics = UIColorMetrics(forAppearance: appearance)
        if self.isHighlighted {
            /*backgroundColor = SFColor.darkBlue
            setTitleColor(SFColor.blue, for: .normal)
            self.layer.borderColor = SFColor.blue.cgColor
            self.layer.borderWidth = 3.0
            tintColor = SFColor.blue*/
            UIView.animate(withDuration: 0.255) {
                self.alpha = 0.6
            }
        } else {
            UIView.animate(withDuration: 0.155) {
                self.alpha = 1.0
            }
            
            backgroundColor = colorMetrics.color(forRelativeHue: .blue)
            setTitleColor(colorMetrics.color(forRelativeHue: .white), for: .normal)
            layer.borderColor = colorMetrics.color(forRelativeHue: .darkBlue).cgColor
            layer.borderWidth = restingBorderWidth
            tintColor = colorMetrics.color(forRelativeHue: .white)
        }
        
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
    @available(iOS, deprecated: 10.0, message: "use 'SFColor' static properties instead")
    private func cacheBackgroundColor(isEnabled: Bool, isHighlighted: Bool, isSelected: Bool) {
        // Cache the background color only if the old value was true.
        if isEnabled, !isHighlighted, !isSelected {
            cachedBackgroundColor = backgroundColor == nil ? nil : SFColor(uiColor: backgroundColor!)
        }
    }
}
