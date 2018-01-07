//
//  UIStoryboard+Identifiable.swift
//  SFKit
//
//  Created by David Moore on 1/7/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

extension UIStoryboard {
    
    /// Instantiates and returns the view controller with the specified identifier.
    ///
    /// - Parameters:
    ///   - type: A 
    open func instantiateViewController<T>(ofType type: T.Type) -> T where T: UIViewController {
        let viewController = instantiateViewController(withIdentifier: type.typeName)
        return viewController as! T
    }
}
