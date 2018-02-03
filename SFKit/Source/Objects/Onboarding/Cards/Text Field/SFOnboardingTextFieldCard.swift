//
//  SFOnboardingTextFieldCard.swift
//  SFKit
//
//  Created by David Moore on 1/28/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

final public class SFOnboardingTextFieldCard: SFOnboardingCard {
    
    /// Cell type that is associated with the descriptor.
    private typealias CardType = SFOnboardingTextFieldCardCell
    
    /// Cell type that is associated with the descriptor.
    public override var associatedCardName: String {
        return CardType.typeName
    }
    
    /// Title will be displayed alongside text field.
    public var localizedTitle: String
    
    /// 
    public var localizedPlaceholder: String?
    
    /// Boolean value indicating if the text field will be for secure text entry.
    public var isSecureTextEntry: Bool
    
    /// Type of return key that will be presented in the cell.
    public var returnKeyType: UIReturnKeyType
    
    /// Initializes a new receiver.
    public init(localizedTitle: String, isSecureTextEntry: Bool, returnKeyType: UIReturnKeyType) {
        self.localizedTitle = localizedTitle
        self.isSecureTextEntry = isSecureTextEntry
        self.returnKeyType = returnKeyType
    }
    
    /// Prepares a card for presentation within a table view.
    ///
    /// - Parameter card: Card that must be configured for display.
    public override func prepare(_ card: SFTableViewCell) {
        let card = card as! CardType
        card.titleLabel.text = localizedTitle
        card.textField.isSecureTextEntry = isSecureTextEntry
        card.textField.returnKeyType = returnKeyType
        card.textField.enablesReturnKeyAutomatically = true
    }
}
