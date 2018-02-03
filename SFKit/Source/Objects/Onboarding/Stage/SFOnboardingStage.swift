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
    public var cards: [SFOnboardingCard]
    
    /// Primary button title that will be presented to users.
    public var primaryControl: SFOnboardingStageControl?
    
    /// Secondary button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the secondary button is hidden.
    public var secondaryControl: SFOnboardingStageControl?
    
    /// Leading button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the leading button is hidden.
    public var leadingControl: SFOnboardingStageControl?
    
    /// Trailing button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the trailing button is hidden.
    public var trailingControl: SFOnboardingStageControl?
    
    /// Accessory label that acts as a secondary UI element which can be found above the `primaryControl`.
    public var accessoryLabel: SFOnboardingStageLabel?
    
    public init(cards: [SFOnboardingCard],
                primaryControl: SFOnboardingStageControl? = nil,
                secondaryControl: SFOnboardingStageControl? = nil,
                leadingControl: SFOnboardingStageControl? = nil,
                trailingControl: SFOnboardingStageControl? = nil,
                accessoryLabel: SFOnboardingStageLabel? = nil) {
        self.cards = cards
        self.primaryControl = primaryControl
        self.secondaryControl = secondaryControl
        self.leadingControl = leadingControl
        self.trailingControl = trailingControl
        self.accessoryLabel = accessoryLabel
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
            lhs.primaryControl == rhs.primaryControl &&
            lhs.secondaryControl == rhs.secondaryControl &&
            lhs.leadingControl == rhs.leadingControl &&
            lhs.trailingControl == rhs.trailingControl &&
            lhs.accessoryLabel == rhs.accessoryLabel
    }
}
