//
//  SFColor.swift
//  SFKit
//
//  Created by David Moore on 6/30/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

/// Add floating point brightness value to the color.
infix operator +: AdditionPrecedence

/// Subtract a floating point brightness value from the color.
infix operator -: AdditionPrecedence

/// Subclasses `UIColor` to provide a more fine-tuned selection of static color variables. `SFColor` also provides an array of more specific color brightness adjustments.
/// Static colors are available as computed properties which are subject to change between different releases of *SFKit*. Any change made to the statically available color scheme is guranteed to be visually compatible, meaning the design will still work as intended.
open class SFColor: UIColor {
    
    // MARK: - Static Colors
    
    /// A true white with a grayscale value of 1.0 and alpha of 1.0.
    open class var trueWhite: SFColor {
        return SFColor(white: 1.0, alpha: 1.0)
    }
    
    /// An off-white color.
    open override class var white: SFColor {
        return #colorLiteral(red: 0.9235673547, green: 0.9301430583, blue: 0.9465145469, alpha: 1)
    }
    
    /// A light gray.
    open override class var lightGray: SFColor {
        return #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1)
    }
    
    /// A medium colored gray.
    open override class var gray: SFColor {
        return #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1)
    }
    
    /// A darker than medium gray.
    open override class var darkGray: SFColor {
        return #colorLiteral(red: 0.6398570538, green: 0.6572751999, blue: 0.6806338429, alpha: 1)
    }
    
    /// A rich blue.
    open override class var blue: SFColor {
        return #colorLiteral(red: 0.02291317284, green: 0.5002143383, blue: 1, alpha: 1)
    }
    
    // MARK: - Initialization
    
    /// Bridge a `UIColor` to an `SFColor` using the underlying `CGColor`.
    public convenience init(uiColor: UIColor) {
        self.init(cgColor: uiColor.cgColor)
    }
    
    // MARK: - Methods
    
    open static func +(lhs: SFColor, rhs: CGFloat) -> SFColor {
        // Get the color space of this color, the components which make up the color space, and the minimum value of those components.
        if let colorSpace = lhs.cgColor.colorSpace,
            let components = lhs.cgColor.components,
            let maximumComponent = components.max() {
            // Calculate the absolute value of the stride, this is the amount
            let stride = abs(maximumComponent - rhs)
            
            // Correct the components by subtracting the stride from each component value.
            let correctedComponents = components.map { max($0 - stride, 0.0) }
            
            // Create a new CGColor from the newly minimalized components.
            if let correctedCGColor = CGColor(colorSpace: colorSpace, components: correctedComponents) {
                let uiColor = UIColor(cgColor: correctedCGColor).withAlphaComponent(lhs.cgColor.alpha)
                return SFColor(uiColor: uiColor)
            } else {
                return lhs
            }
        } else {
            return lhs
        }
    }
    
    open static func -(lhs: SFColor, rhs: CGFloat) -> SFColor {
        // Get the color space of this color, the components which make up the color space, and the minimum value of those components.
        if let colorSpace = lhs.cgColor.colorSpace,
            let components = lhs.cgColor.components,
            let minimumComponent = components.min() {
            // Calculate the absolute value of the stride, this is the amount
            let stride = abs(minimumComponent - rhs)
            
            // Correct the components by subtracting the stride from each component value.
            let correctedComponents = components.map { max($0 - stride, 0.0) }
            
            // Create a new CGColor from the newly minimalized components.
            if let correctedCGColor = CGColor(colorSpace: colorSpace, components: correctedComponents) {
                let uiColor = UIColor(cgColor: correctedCGColor).withAlphaComponent(lhs.cgColor.alpha)
                return SFColor(uiColor: uiColor)
            } else {
                return lhs
            }
        } else {
            return lhs
        }
    }
    
    /// Creates a new `SFColor` by darkening this color by a given `value`; the darkened color may be equal to this one in the case where it is already as dark as possible.
    ///
    /// - Parameter value: A non-negative value by which the color will be darkened by. This value may not be met if the color components cannot support the diffusion.
    /// - Returns: New `SFColor` darkened by the provided `value`.
    open func correct(by value: CGFloat) -> SFColor {
        // Assert that the value must be positive.
        // assert(value >= 0, "Cannot darken by a negative value.")
        
        // Get the color space of this color, the components which make up the color space, and the minimum value of those components.
        if let colorSpace = cgColor.colorSpace,
            let components = cgColor.components?.reversed().filter({ $0 != cgColor.alpha }).reversed(),
            let minimumComponent = components.min() {
            // Calculate the absolute value of the stride, this is the amount
            let stride = abs(minimumComponent - value)
            
            // Correct the components by subtracting the stride from each component value.
            let correctedComponents = components.map { max($0 - stride, 0.0) }
            
            // Create a new CGColor from the newly minimalized components.
            if let correctedCGColor = CGColor(colorSpace: colorSpace, components: correctedComponents) {
                return SFColor(cgColor: correctedCGColor)
            } else {
                return self
            }
        } else {
            return self
        }
    }
}
