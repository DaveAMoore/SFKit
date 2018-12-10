//
//  UIStoryboard+Identifiable.swift
//  SFKit
//
//  Created by David Moore on 1/7/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

import UIKit

extension UITableView {
    
    open func dequeueReusableCell<T>(ofType type: T.Type, withIdentifier reuseIdentifier: String, for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
    }
    
    open func dequeueReusableCell<T>(ofType type: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(ofType: type, withIdentifier: type.typeName, for: indexPath)
    }
    
    open func cell<T>(ofType type: T.Type, forRowAt indexPath: IndexPath) -> T? where T: UITableViewCell {
        return cellForRow(at: indexPath) as? T
    }
}

extension UICollectionView {
    
    open func dequeueReusableCell<T>(_ type: T.Type, withIdentifier reuseIdentifier: String, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
    
    open func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(type, withIdentifier: type.typeName, for: indexPath)
    }
    
    open func cell<T>(_ type: T.Type, forItemAt indexPath: IndexPath) -> T? where T: UICollectionViewCell {
        return cellForItem(at: indexPath) as? T
    }
    
    @available(*, deprecated, renamed: "dequeueReusableCell(_:withIdentifier:for:)")
    open func dequeueReusableCell<T>(ofType type: T.Type, withIdentifier reuseIdentifier: String, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(type, withIdentifier: reuseIdentifier, for: indexPath)
    }
    
    @available(*, deprecated, renamed: "dequeueReusableCell(_:for:)")
    open func dequeueReusableCell<T>(ofType type: T.Type, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(type, withIdentifier: type.typeName, for: indexPath)
    }
    
    @available(*, deprecated, renamed: "cell(_:forItemAt:)")
    open func cell<T>(ofType type: T.Type, forItemAt indexPath: IndexPath) -> T? where T: UICollectionViewCell {
        return cellForItem(at: indexPath) as? T
    }
}

extension UIStoryboard {
    
    public static let main = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    open func instantiateViewController<T>(_ type: T.Type) -> T where T: UIViewController {
        return instantiateViewController(withIdentifier: type.typeName) as! T
    }
    
    @available(*, deprecated, renamed: "instantiateViewController(_:)")
    open func instantiateViewController<T>(ofType type: T.Type) -> T where T: UIViewController {
        let viewController = instantiateViewController(withIdentifier: type.typeName)
        return viewController as! T
    }
}

extension CGColor {
    
    /// Result for the comparison of two `CGColor` instances.
    public enum CGColorComparisonResult {
        case equal
        case approximatelyEqual(Float)
        case notEqual
    }
    
    /// Compares a particular color with the receiver.
    ///
    /// - Parameter b: Color that will be compared with the receiver.
    /// - Returns: Comparison result for the receiver and `b`.
    public func compare(to b: CGColor) -> CGColorComparisonResult {
        // Create a color space for comparison purposes.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Convert the colors using a perceptual intent, which is necessary for color space mapping.
        let a = converted(to: colorSpace, intent: .perceptual, options: nil)
        let b = b.converted(to: colorSpace, intent: .perceptual, options: nil)
        
        // Unwrap the component values.
        guard a?.numberOfComponents == b?.numberOfComponents, let aComponents = a?.components, let bComponents = b?.components else { return .notEqual }
        
        // Calculate the confidence level.
        let confidence = Float(aComponents.enumerated().reduce(1, { max(0, $0 - abs($1.element - bComponents[$1.offset])) }))
        
        // Analyze the confidence level.
        if confidence > 0.92 {
            return confidence == 1 ? .equal : .approximatelyEqual(confidence)
        } else {
            return .notEqual
        }
    }
}
