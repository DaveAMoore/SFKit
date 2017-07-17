//
//  SFButton.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 6/29/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable public final class SFButton: UIButton, SFAppearanceProtocol {
    
    // MARK: - Properties
    
    /// Appearance of the designable object.
    public let appearance: SFAppearance = .global
    
    /// Unique `SFAppearance` style observation token.
    public var appearanceStyleObserver: NSObjectProtocol?
    
    /// Cached background color that is used for selection and enabling.
    private var cachedBackgroundColor: SFColor?
    
    // MARK: - Inspectable Properties
    
    /// Boolean value determining whether or not the appearance will be forcefully applied.
    @IBInspectable public var shouldEnforceAppearance: Bool = true
    
    /// Boolean value indicating if the corner radius of the button is equal to the halving of the minimal dimension (width or height).
    @IBInspectable public var isElliptical: Bool {
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
    public override var frame: CGRect {
        didSet {
            isElliptical = layer.cornerRadius == ellipticalCornerRadius(for: oldValue)
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            guard isEnabled != oldValue else { return }
            
            // Cache the background color.
            cacheBackgroundColor(isEnabled: oldValue, isHighlighted: isHighlighted, isSelected: isSelected)
            
            // Adjust the background color as needed.
            if isEnabled {
                backgroundColor = cachedBackgroundColor
            } else {
                backgroundColor = SFColor.tertiary.withAlphaComponent(0.5)
            }
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
            
            // Cache the background color, just in case.
            cacheBackgroundColor(isEnabled: isEnabled, isHighlighted: isHighlighted, isSelected: oldValue)
            
            if isSelected {
                backgroundColor = .white
                layer.borderColor = cachedBackgroundColor?.cgColor
                layer.borderWidth = 2.0
                setTitleColor(cachedBackgroundColor, for: .selected)
            } else {
                backgroundColor = cachedBackgroundColor
                layer.borderColor = UIColor.clear.cgColor
                setTitleColor(.white, for: .normal)
            }
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            
            // Cache the background color, just in case.
            cacheBackgroundColor(isEnabled: isEnabled, isHighlighted: oldValue, isSelected: isSelected)
            
            // Adjust as needed.
            if isHighlighted {
                backgroundColor = cachedBackgroundColor! - 0.1
                layer.borderColor = cachedBackgroundColor?.cgColor
                layer.borderWidth = 2.0
                setTitleColor(cachedBackgroundColor, for: .highlighted)
            } else {
                backgroundColor = cachedBackgroundColor
                layer.borderColor = UIColor.clear.cgColor
                setTitleColor(.white, for: .normal)
            }
        }
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    // MARK: - Deinitialization
    
    deinit {
        unregisterForAppearanceUpdates()
    }
    
    // MARK: - Appearance
    
    public func updateDesign(for appearance: SFAppearance) {
        // Prevent asserting the defaults if the default design shall not be enforced.
        guard shouldEnforceAppearance else { return }
        
        // Set a San Fransisco blue color as the background color.
        backgroundColor = SFColor.interactive
        
        // The button defaults to be elliptical in presentation.
        isElliptical = true
        
        // Set the title color to our San Fransisco white.
        setTitleColor(SFColor.primary, for: .normal)
        
        // Add the preferred font as headline.
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // Set the default content edge insets value.
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
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
