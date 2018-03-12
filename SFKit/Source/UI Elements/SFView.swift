//
//  SFView.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable open class SFView: UIView {
    
    // MARK: - Properties
    
    @available(*, deprecated, message: "use 'adjustsColorForAppearanceStyle' instead")
    @IBInspectable open var shouldEnforceAppearance: Bool = false
    
    /// Corner radius of the view.
    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
}
