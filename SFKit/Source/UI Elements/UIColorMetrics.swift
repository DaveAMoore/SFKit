//
//  UIColorMetrics.swift
//  SFKit
//
//  Created by David Moore on 3/10/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

// MARK: - Color Selection

/// Enumeration containing range of colors.
@objc public enum UIColorMetricsHue: Int {
    case red = 1
    case orange
    case yellow
    case green
    case tealBlue
    case blue
    case darkBlue
    case purple
    case pink
    case white
    case extraLightGray
    case lightGray
    case gray
    case darkGray
    case extraDarkGray
    case black = 0
}

@objc open class UIColorMetrics: NSObject {
    
    // MARK: - Properties
    
    /// Appearance style for the color metrics.
    private var appearanceStyle: SFAppearanceStyle
    
    // MARK: - Initialization
    
    /// The default color metrics object for content. Initialized with `SFAppearance.global`.
    @objc public class var `default`: UIColorMetrics {
        return UIColorMetrics(forAppearance: .global)
    }
    
    /// Creates a color metrics object for the provided appearance.
    @objc public convenience init(forAppearance appearance: SFAppearance) {
        self.init(forAppearanceStyle: appearance.style)
    }
    
    /// Creates a color metrics object for the specified appearance style.
    @objc public init(forAppearanceStyle appearanceStyle: SFAppearanceStyle) {
        self.appearanceStyle = appearanceStyle
    }
    
    // MARK: - Interface
    
    /// Returns a color adapted for the appearance style the receiver was initialized for.
    ///
    /// - Parameter hue: Color that is relative to the **light** appearance style.
    /// - Returns: Color that has been adapted for the initially specified appearance style.
    @objc open func color(forRelativeHue hue: UIColorMetricsHue) -> UIColor {
        switch hue {
        case .red:
            return red
        case .orange:
            return orange
        case .yellow:
            return yellow
        case .green:
            return green
        case .tealBlue:
            return tealBlue
        case .blue:
            return blue
        case .darkBlue:
            return darkBlue
        case .purple:
            return purple
        case .pink:
            return pink
        case .white:
            return white
        case .extraLightGray:
            return extraLightGray
        case .lightGray:
            return lightGray
        case .gray:
            return gray
        case .darkGray:
            return darkGray
        case .extraDarkGray:
            return extraDarkGray
        case .black:
            return black
        }
    }
    
    /// Returns the relative hue for the provided color.
    ///
    /// - Parameter color: Color that will be matched to a color metrics hue.
    /// - Returns: Color metrics hue that is associated with the provided color, relative to the appearance style with which the receiver was initialized.
    @objc open func relativeHue(forColor color: UIColor) -> UIColorMetricsHue {
        let colors: [UIColor: UIColorMetricsHue] = [red: .red, orange: .orange, .yellow: .yellow,
                                                    green: .green, tealBlue: .tealBlue, blue: .blue,
                                                    purple: .purple, pink: .pink, white: .white,
                                                    extraLightGray: .extraLightGray, lightGray: .lightGray,
                                                    gray: .gray, darkGray: .darkGray,
                                                    extraDarkGray: .extraDarkGray, black: .black]
        
        return colors[color] ?? .black
    }
    
    /// Returns a color that is relative
    ///
    /// - Parameters:
    ///   - relativeColor: <#relativeColor description#>
    ///   - relativeAppearanceStyle: <#relativeAppearanceStyle description#>
    /// - Returns: <#return value description#>
    /* @objc open func color(forRelativeColor relativeColor: UIColor, withRespectTo relativeAppearanceStyle: SFAppearanceStyle) -> UIColor {
        let relativeHue = UIColorMetrics(forAppearanceStyle: relativeAppearanceStyle).relativeHue(forColor: relativeColor)
        return color(forRelativeHue: relativeHue)
    } */
    
    // MARK: - Colors
    
    private var red: UIColor {
        switch appearanceStyle {
        case .light:
            return #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        case .dark:
            return #colorLiteral(red: 0.9952381253, green: 0.3384355307, blue: 0.1943919361, alpha: 1)
        }
    }
    
    private var orange: UIColor {
        switch appearanceStyle {
        case .light, .dark:
            return #colorLiteral(red: 1, green: 0.5583720207, blue: 0, alpha: 1)
        }
    }
    
    private var yellow: UIColor {
        switch appearanceStyle {
        case .light, .dark:
            return #colorLiteral(red: 1, green: 0.7921642661, blue: 0, alpha: 1)
        }
    }
    
    private var green: UIColor {
        switch appearanceStyle {
        case .light, .dark:
            return #colorLiteral(red: 0, green: 0.8660034537, blue: 0.3203170896, alpha: 1)
        }
    }
    
    private var tealBlue: UIColor {
        switch appearanceStyle {
        case .light:
            return #colorLiteral(red: 0, green: 0.7967023253, blue: 1, alpha: 1)
        case .dark:
            return UIColorMetrics(forAppearanceStyle: .light).color(forRelativeHue: .blue)
        }
    }
    
    private var blue: UIColor {
        switch appearanceStyle {
        case .light:
            return #colorLiteral(red: 0.02291317284, green: 0.5002143383, blue: 1, alpha: 1)
        case .dark:
            return UIColorMetrics(forAppearanceStyle: .light).color(forRelativeHue: .tealBlue)
        }
    }
    
    private var darkBlue: UIColor {
        switch appearanceStyle {
        case .light:
            return #colorLiteral(red: 0, green: 0.368126277, blue: 1, alpha: 1)
        case .dark:
            return #colorLiteral(red: 0.2773995536, green: 0.9073827713, blue: 1, alpha: 1)
        }
    }
    
    private var purple: UIColor {
        switch appearanceStyle {
        case .light, .dark:
            return #colorLiteral(red: 0.3467972279, green: 0.3371668756, blue: 0.8699499965, alpha: 1)
        }
    }
    
    private var pink: UIColor {
        switch appearanceStyle {
        case .light, .dark:
            return #colorLiteral(red: 1, green: 0, blue: 0.3104304075, alpha: 1)
        }
    }
    
    // MARK: Grayscale
    
    /// An off-white color.
    private var white: UIColor {
        switch appearanceStyle {
        case .light:
            return .white
        case .dark:
            return #colorLiteral(red: 0.1992851496, green: 0.1992851496, blue: 0.1992851496, alpha: 1)
        }
    }
    
    private var extraLightGray: UIColor {
        switch appearanceStyle {
        case .light:
            return #colorLiteral(red: 0.9035493731, green: 0.9035493731, blue: 0.9035493731, alpha: 1)
        case .dark:
            return UIColorMetrics(forAppearanceStyle: .light).color(forRelativeHue: .extraDarkGray)
        }
    }
    
    /// A light gray.
    private var lightGray: UIColor {
        switch appearanceStyle {
        case .light:
            return #colorLiteral(red: 0.7952535152, green: 0.7952535152, blue: 0.7952535152, alpha: 1)
        case .dark:
            return UIColorMetrics(forAppearanceStyle: .light).color(forRelativeHue: .darkGray)
        }
    }
    
    /// A medium colored gray.
    private var gray: UIColor {
        switch appearanceStyle {
        case .light, .dark:
            return #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
        }
    }
    
    /// A darker than medium gray.
    private var darkGray: UIColor {
        switch appearanceStyle {
        case .light:
            return #colorLiteral(red: 0.45389539, green: 0.45389539, blue: 0.45389539, alpha: 1)
        case .dark:
            return UIColorMetrics(forAppearanceStyle: .light).color(forRelativeHue: .lightGray)
        }
    }
    
    private var extraDarkGray: UIColor {
        switch appearanceStyle {
        case .light:
            return #colorLiteral(red: 0.3179988265, green: 0.3179988265, blue: 0.3179988265, alpha: 1)
        case .dark:
            return UIColorMetrics(forAppearanceStyle: .light).color(forRelativeHue: .extraLightGray)
        }
    }
    
    /// Depp black color which is adaptive.
    private var black: UIColor {
        switch appearanceStyle {
        case .light:
            return .black
        case .dark:
            return UIColorMetrics(forAppearanceStyle: .light).color(forRelativeHue: .white)
        }
    }
}
