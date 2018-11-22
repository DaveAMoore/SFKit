//
//  SFOnboardingTextFieldCard.swift
//  SFKit
//
//  Created by David Moore on 1/28/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

open class SFOnboardingTextFieldCard: SFOnboardingCard {
    
    // MARK: - Properties
    
    /// Type of cell that will be created for the card.
    open override var cellType: UITableViewCell.Type {
        return SFOnboardingTextFieldCardCell.self
    }
    
    /// Displays the title that is presented alongside the text field.
    open var titleLabel: SFOnboardingLabel?
    
    ///
    open var textField: SFOnboardingTextField
    
    /// MARK: - Initialization
    
    /// Initializes a new receiver.    
    public init(titleLabel: SFOnboardingLabel?, textField: SFOnboardingTextField) {
        self.titleLabel = titleLabel
        self.textField = textField
        super.init()
        self.selectionStyle = .none
    }
    
    // MARK: - Interface
    
    /// Prepares a card for presentation within a table view.
    ///
    /// - Parameter card: Card that must be configured for display.
    open override func prepare(_ card: UITableViewCell, forController controller: SFOnboardingStageViewController?) {
        super.prepare(card, forController: controller)
        
        let card = card as! SFOnboardingTextFieldCardCell
        if let titleLabel = titleLabel {
            titleLabel.prepare(card.titleLabel)
        } else {
            card.titleLabel.text = nil
        }
        textField.prepare(card.textField, withDefaultAction: nil, for: controller)
    }
}
