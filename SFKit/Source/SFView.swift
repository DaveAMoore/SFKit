//
//  SFView.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@IBDesignable
public class SFView: UIView, SFAppearanceProtocol {
    
    // MARK: - Properties
    
    @IBInspectable public var shouldEnforceAppearance: Bool = false
    
    /// Corner radius of the view.
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    // MARK: - Setup
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        // Perform any additional setup here.
        
        // Register for appearance updates.
        registerForAppearanceUpdates()
    }
    
    public override func removeFromSuperview() {
        super.removeFromSuperview()
        // Perform any additional deconstruction here.
        
        // Unregister from updates regarding changes.
        unregisterForAppearanceUpdates()
    }
    
    // MARK: - Update Methods
    
    /// This method is called whenever the appearance an object is correlated to, changes.
    ///
    /// - Parameter notification: The notification that caused the method to be called.
    public func appearanceStyleDidChange(_ notification: Notification) {        
        backgroundColor = SFColor.white
    }
}
