//
//  SFColor.swift
//  Tone MessagesExtension
//
//  Created by David Moore on 6/30/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

public class SFColor: UIColor {
    
    // MARK: - Static Colors
    
    public class var trueWhite: SFColor {
        return SFColor(white: 1.0, alpha: 1.0)
    }
    
    public override class var white: SFColor {
        return #colorLiteral(red: 0.9235673547, green: 0.9301430583, blue: 0.9465145469, alpha: 1)
    }
    
    public override class var lightGray: SFColor {
        return #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1)
    }
    
    public override class var gray: SFColor {
        return #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1)
    }
    
    public override class var darkGray: SFColor {
        return #colorLiteral(red: 0.6398570538, green: 0.6572751999, blue: 0.6806338429, alpha: 1)
    }
    
    public override class var blue: SFColor {
        return #colorLiteral(red: 0.02291317284, green: 0.5002143383, blue: 1, alpha: 1)
    }
    
    // MARK: - Methods
    
    /// Creates a new `SFColor` by darkening this color by a given `value`; the darkened color may be equal to this one in the case where it is already as dark as possible.
    ///
    /// - Parameter value: A non-negative value by which the color will be darkened by. This value may not be met if the color components cannot support the diffusion.
    /// - Returns: New `SFColor` darkened by the provided `value`.
    public func darkening(by value: CGFloat) -> SFColor {
        // Assert that the value must be positive.
        assert(value >= 0, "Cannot darken by a negative value.")
        
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
