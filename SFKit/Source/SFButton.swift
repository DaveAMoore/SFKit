//
//  SFButton.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 6/29/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable public class SFButton: UIButton {
    
    // MARK: - Properties
    
    /// Cached background color that is used for selection and enabling.
    private var cachedBackgroundColor: UIColor?
    
    /// Boolean value indicating if the corner radius of the button is equal to the halving of the minimal dimension (width or height).
    @IBInspectable public var isElliptical: Bool {
        get {
            return layer.cornerRadius == ellipticalCornerRadius()
        } set {
            layer.cornerRadius = ellipticalCornerRadius()
        }
    }
    
    // MARK: - State Management
    
    override public var isEnabled: Bool {
        didSet {
            guard isEnabled != oldValue else { return }
            
            // Cache the background color.
            cacheBackgroundColor(withOldValue: oldValue)
            
            // Adjust the background color as needed.
            if isEnabled {
                backgroundColor = cachedBackgroundColor
            } else {
                backgroundColor = cachedBackgroundColor?.withAlphaComponent(0.5)
            }
        }
    }
    
    /*
    override public var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
            
            // Cache the background color, just in case.
            cacheBackgroundColor(withOldValue: !oldValue)
            
            if isSelected {
                layer.borderColor = cachedBackgroundColor?.cgColor
                layer.borderWidth = 2.0
                setTitleColor(cachedBackgroundColor, for: .selected)
            } else {
                layer.borderColor = UIColor.clear.cgColor
                setTitleColor(.white, for: .normal)
            }
        }
    } */
    
    public override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            
            // Cache the background color, just in case.
            cacheBackgroundColor(withOldValue: !oldValue)
            
            // Adjust as needed.
            if isHighlighted {
                backgroundColor = .white
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
        
        // Set the default values.
        setDefaults()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Assign default values to whichever aspects usually need manipulation.
        setDefaults()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        // Make sure the default values are setup.
        setDefaults()
    }
    
    // MARK: - Helper Methods
    
    /// Sets the button's default appearance values.
    private func setDefaults() {
        // Set a San Fransisco blue color as the background color.
        backgroundColor = SFColor.blue
        
        // The button defaults to be elliptical in presentation.
        isElliptical = true
        
        setTitleColor(SFColor.white, for: .normal)
        
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // Set the default content edge insets value.
        contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    /// Generates an elliptical corner radius value.
    ///
    /// - Returns: `CGFloat` value representing the floored value of the minimal dimension divided by two (half the dimension), represents the corner radius for an elliptical (pill-shaped) button.
    private func ellipticalCornerRadius() -> CGFloat {
        return floor(min(frame.width, frame.height) / 2)
    }
    
    /// Caches the background color if required.
    ///
    /// - Parameter oldValue: The last value of the property which is calling this caching method.
    private func cacheBackgroundColor(withOldValue oldValue: Bool) {
        // Cache the background color only if the old value was true.
        if oldValue {
            cachedBackgroundColor = backgroundColor
        }
    }
    
}
