//
//  SFOnboardingStage.swift
//  SFKit
//
//  Created by David Moore on 1/28/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

import Foundation

/// Single step within onboarding controller.
public class SFOnboardingStage: NSObject {
    
    // MARK: - Properties
    
    /// Collection of cards that will be presented by the receiver.
    public var cards: [SFOnboardingCard]
    
    /// Primary button title that will be presented to users.
    public var primaryControl: SFOnboardingControl?
    
    /// Secondary button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the secondary button is hidden.
    public var secondaryControl: SFOnboardingControl?
    
    /// Leading button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the leading button is hidden.
    public var leadingControl: SFOnboardingControl?
    
    /// Trailing button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the trailing button is hidden.
    public var trailingControl: SFOnboardingControl?
    
    /// Accessory label that acts as a secondary UI element which can be found above the `primaryControl`.
    public var accessoryLabel: SFOnboardingLabel?
    
    /// Action that will be invoked when a table view cell is selected.
    public var cellSelected: SFOnboardingControl.Action?
    
    // MARK: - Initialization
    
    public override init() {
        cards = []
        super.init()
    }
    
    @available(*, deprecated)
    public init(cards: [SFOnboardingCard],
                primaryControl: SFOnboardingControl? = nil,
                secondaryControl: SFOnboardingControl? = nil,
                leadingControl: SFOnboardingControl? = nil,
                trailingControl: SFOnboardingControl? = nil,
                accessoryLabel: SFOnboardingLabel? = nil,
                cellSelected: SFOnboardingControl.Action? = nil) {
        self.cards = cards
        self.primaryControl = primaryControl
        self.secondaryControl = secondaryControl
        self.leadingControl = leadingControl
        self.trailingControl = trailingControl
        self.accessoryLabel = accessoryLabel
        self.cellSelected = cellSelected
    }
}
