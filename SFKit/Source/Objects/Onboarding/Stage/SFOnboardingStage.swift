//
//  SFOnboardingStage.swift
//  SFKit
//
//  Created by David Moore on 1/28/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

/// Single step within onboarding controller.
public struct SFOnboardingStage: Equatable {
    
    /// Collection of cards that will be presented by the receiver.
    public var cards: [SFOnboardingCardDescriptor]
    
    /// Primary button title that will be presented to users.
    public var primaryButtonLocalizedTitle: String
    
    /// Secondary button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the secondary button is hidden.
    public var secondaryButtonLocalizedTitle: String?
    
    /// Leading button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the leading button is hidden.
    public var leadingButtonLocalizedTitle: String?
    
    /// Trailing button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the trailing button is hidden.
    public var trailingButtonLocalizedTitle: String?
    
    public init(cards: [SFOnboardingCardDescriptor], primaryButtonLocalizedTitle: String,
                secondaryButtonLocalizedTitle: String? = nil, leadingButtonLocalizedTitle: String? = nil,
                trailingButtonLocalizedTitle: String? = nil) {
        self.cards = cards
        self.primaryButtonLocalizedTitle = primaryButtonLocalizedTitle
        self.secondaryButtonLocalizedTitle = secondaryButtonLocalizedTitle
        self.leadingButtonLocalizedTitle = leadingButtonLocalizedTitle
        self.trailingButtonLocalizedTitle = trailingButtonLocalizedTitle
    }
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: SFOnboardingStage, rhs: SFOnboardingStage) -> Bool {
        return lhs.cards == rhs.cards &&
            lhs.primaryButtonLocalizedTitle == rhs.primaryButtonLocalizedTitle &&
            lhs.secondaryButtonLocalizedTitle == rhs.secondaryButtonLocalizedTitle &&
            lhs.leadingButtonLocalizedTitle == rhs.leadingButtonLocalizedTitle &&
            lhs.trailingButtonLocalizedTitle == rhs.trailingButtonLocalizedTitle
    }
}
