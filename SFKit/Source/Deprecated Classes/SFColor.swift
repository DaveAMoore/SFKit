//
//  SFColor.swift
//  SFKit
//
//  Created by David Moore on 6/30/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit
import SFModelCheck

/// Add floating point brightness value to the color.
infix operator +: AdditionPrecedence

/// Subtract a floating point brightness value from the color.
infix operator -: AdditionPrecedence

/// Subclasses `UIColor` to provide a more fine-tuned selection of static color variables. `SFColor` also provides an array of more specific color brightness adjustments.
/// Static colors are available as computed properties which are subject to change between different releases of *SFKit*. Any change made to the statically available color scheme is guranteed to be visually compatible, meaning the design will still work as intended.
/// The color values exposed by `SFColor` are guaranteed to be reflective of the current global appearance style. The color cannot be expected to update autonomously in the event of an appearance style change, therefore colors must be updated by setting the statically defined colors again. The caller is fully responsible for color changes to take place.
@available(*, deprecated, message: "use SFColorMetrics instead")
open class SFColor: UIColor {
    
    // MARK: - Adaptive Colors
    
    /// A true white with a grayscale value of 1.0 and an alpha of 1.0.
    open class var trueWhite: SFColor {
        return SFColor(white: 1.0, alpha: 1.0)
    }
    
    /// A true black with a grayscale value of 0.0 and an alpha of 1.0.
    open class var trueBlack: SFColor {
        return SFColor(white: 0.0, alpha: 1.0)
    }
    
    // MARK: Colorful
    
    open override class var red: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.9952381253, green: 0.3384355307, blue: 0.1943919361, alpha: 1)
    }
    
    open override class var orange: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 1, green: 0.5583720207, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.5583720207, blue: 0, alpha: 1)
    }
    
    open override class var yellow: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 1, green: 0.7921642661, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.7921642661, blue: 0, alpha: 1)
    }
    
    open override class var green: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0, green: 0.8660034537, blue: 0.3203170896, alpha: 1) : #colorLiteral(red: 0, green: 0.8660034537, blue: 0.3203170896, alpha: 1)
    }
    
    open class var tealBlue: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0, green: 0.7967023253, blue: 1, alpha: 1) : #colorLiteral(red: 0.02291317284, green: 0.5002143383, blue: 1, alpha: 1)
    }
    
    open override class var blue: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.02291317284, green: 0.5002143383, blue: 1, alpha: 1) : #colorLiteral(red: 0.3528000116, green: 0.7813866735, blue: 0.9800000787, alpha: 1)
    }
    
    open override class var purple: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.3467972279, green: 0.3371668756, blue: 0.8699499965, alpha: 1) : #colorLiteral(red: 0.3467972279, green: 0.3371668756, blue: 0.8699499965, alpha: 1)
    }
    
    open class var pink: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 1, green: 0, blue: 0.3104304075, alpha: 1) : #colorLiteral(red: 1, green: 0, blue: 0.3104304075, alpha: 1)
    }
    
    // MARK: Grayscale
    
    /// An off-white color.
    open override class var white: SFColor {
        return isLightAppearance() ? .trueWhite : #colorLiteral(red: 0.1992851496, green: 0.1992851496, blue: 0.1992851496, alpha: 1)
    }
    
    open class var extraLightGray: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.9035493731, green: 0.9035493731, blue: 0.9035493731, alpha: 1) : #colorLiteral(red: 0.3179988265, green: 0.3179988265, blue: 0.3179988265, alpha: 1)
    }
    
    /// A light gray.
    open override class var lightGray: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.7952535152, green: 0.7952535152, blue: 0.7952535152, alpha: 1) : #colorLiteral(red: 0.45389539, green: 0.45389539, blue: 0.45389539, alpha: 1)
    }
    
    /// A medium colored gray.
    open override class var gray: SFColor {
        return #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
    }
    
    /// A darker than medium gray.
    open override class var darkGray: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.45389539, green: 0.45389539, blue: 0.45389539, alpha: 1) : #colorLiteral(red: 0.7952535152, green: 0.7952535152, blue: 0.7952535152, alpha: 1)
    }
    
    open class var extraDarkGray: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.3179988265, green: 0.3179988265, blue: 0.3179988265, alpha: 1) : #colorLiteral(red: 0.9035493731, green: 0.9035493731, blue: 0.9035493731, alpha: 1)
    }
    
    /// Depp black color which is adaptive.
    open override class var black: SFColor {
        return isLightAppearance() ? .trueBlack : .trueWhite
    }
    
    // MARK: - Unavailable Colors
    
    /// Primary color which is to be used for almost all general purposes. This is *white* for the `light` appearance style, and black (almost) for the `dark` appearance style.
    @available(iOS, unavailable, renamed: "white")
    open class var primary: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.1691493392, green: 0.17036134, blue: 0.1733545065, alpha: 1)
    }
    
    /// Secondary to the primary color in hierarchy; designed to be used on top of a primary base or something of the sort.
    @available(iOS, unavailable, renamed: "lightGray")
    open class var secondary: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1) : #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1)
    }
    
    /// Third in line from the primary color; use in compliment of the primary color scheme.
    @available(iOS, unavailable, renamed: "gray")
    open class var tertiary: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1) : #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1)
    }
    
    /// Fourth in line for the primary color scheme; use with any of the primary scheme colors.
    @available(iOS, unavailable, renamed: "darkGray")
    open class var quaternary: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.6398570538, green: 0.6572751999, blue: 0.6806338429, alpha: 1) : #colorLiteral(red: 0.6398570538, green: 0.6572751999, blue: 0.6806338429, alpha: 1)
    }
    
    /// Color which contrasts quite vibrantly with the `primary` color. This is generally *black* for the `light` appearance style, or *white* for the `dark` appearance style.
    @available(iOS, unavailable, renamed: "black")
    open class var contrastive: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.03817283735, green: 0.03845255449, blue: 0.03919008374, alpha: 1) : #colorLiteral(red: 0.9235673547, green: 0.9301430583, blue: 0.9465145469, alpha: 1)
    }
    
    /// Indicates interaction is applicable to the colored object.
    @available(iOS, unavailable, renamed: "blue")
    open class var interactive: SFColor {
        return isLightAppearance() ? #colorLiteral(red: 0.02291317284, green: 0.5002143383, blue: 1, alpha: 1) : #colorLiteral(red: 0.02291317284, green: 0.5002143383, blue: 1, alpha: 1)
    }
    
    // MARK: - Initialization
    
    /// Bridge a `UIColor` to an `SFColor` using the underlying `CGColor`.
    public convenience init(uiColor: UIColor) {
        self.init(cgColor: uiColor.cgColor)
    }
    
    // MARK: - Private Helper Methods
    
    @inline(__always) private class func isLightAppearance() -> Bool {
        return SFAppearance.global.style == .light
    }
    
    // MARK: - Methods
    
    public static func +(lhs: SFColor, rhs: CGFloat) -> SFColor {
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
    
    public static func -(lhs: SFColor, rhs: CGFloat) -> SFColor {
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
