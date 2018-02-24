//
//  SFOnboardingElement.swift
//  SFKit
//
//  Created by David Moore on 2/1/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

open class SFOnboardingElement<T: NSObject>: NSObject {
    
    /// Universally unique identifier corresponding to this control only.
    private let uuid: UUID = UUID()
    
    /// Primary button title that will be presented to users.
    open var localizedTitle: String
    
    /// Dictionary of keys and associated values. This collection is not type safe, and thus should be handled with extreme care.
    open lazy var keyedValues: [String: Any] = [:]
    
    /// Initializes a new stage control using the title & actions specified.
    ///
    /// - Parameters:
    ///   - localizedTitle: Title will be presented to the user for a given control.
    ///   - actions: Collection of all actions that may be performed for the control object. Default value is `[.default]`.
    public init(localizedTitle: String) {
        self.localizedTitle = localizedTitle
    }
    
    /// Prepares an element of generic type `T`.
    ///
    /// - Parameter element: The element that will be prepared.
    open func prepare(_ element: T) {
        element.setValuesForKeys(keyedValues)
    }
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: SFOnboardingElement, rhs: SFOnboardingElement) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
