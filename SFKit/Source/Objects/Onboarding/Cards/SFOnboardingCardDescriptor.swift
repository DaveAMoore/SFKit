//
//  SFOnboardingCardDescriptor.swift
//  SFKit
//
//  Created by David Moore on 1/28/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

/// A discrete unit for an `SFOnboardingStage`. A particular stage will have cards associated with it, as this structure represents the content component.
open class SFOnboardingCardDescriptor: Equatable {
    
    /// Universally unique identifier associated with the receiver.
    private let uuid = UUID()
    
    /// Cell type that is associated with the descriptor.    
    open var associatedCardName: String {
        fatalError("expected 'associatedCardName' computed property to be implemented")
    }
    
    /// Prepares a card for presentation within a table view.
    ///
    /// - Parameter card: Card that must be configured for display.
    open func prepare(_ card: SFTableViewCell) {
        fatalError("expected 'prepare(_:)' to be implemented")
    }
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: SFOnboardingCardDescriptor, rhs: SFOnboardingCardDescriptor) -> Bool {
        return lhs.associatedCardName == rhs.associatedCardName && lhs.uuid == rhs.uuid
    }
}
