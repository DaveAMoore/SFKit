//
//  SFOnboardingTitleCardDescriptor.swift
//  SFKit
//
//  Created by David Moore on 1/28/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

public class SFOnboardingTitleCardDescriptor: SFOnboardingCardDescriptor {
    
    /// Cell type that is associated with the descriptor.
    private typealias CardType = SFOnboardingTitleCard
    
    /// Cell type that is associated with the descriptor.
    public override var associatedCardName: String {
        return CardType.typeName
    }
    
    /// Title will be displayed beneath the `image` `UIImageView`.
    public var localizedTitle: String
    
    /// Description will be presented beneath the `localizedTitle` in the label.
    public var localizedDescription: String?
    
    /// Image will be displayed above the `localizedTitle` label.
    public var image: UIImage?
    
    /// Boolean value indicating if the separator will be hidden on the card.
    public var separatorIsHidden: Bool
    
    /// Initializes a new receiver.
    public init(localizedTitle: String, localizedDescription: String? = nil, image: UIImage? = nil,
                separatorIsHidden: Bool = true) {
        self.localizedTitle = localizedTitle
        self.localizedDescription = localizedDescription
        self.image = image
        self.separatorIsHidden = separatorIsHidden
    }
    
    /// Prepares a card for presentation within a table view.
    ///
    /// - Parameter card: Card that must be configured for display.
    public override func prepare(_ card: SFTableViewCell) {
        let card = card as! CardType
        card.titleLabel.text = localizedTitle
        card.detailLabel.text = localizedDescription
        card.embeddedImageView.image = image
        card.separatorInset = separatorIsHidden ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude) : UIEdgeInsets(top: 0, left: card.layoutMargins.left, bottom: 0, right: 0)
    }
}
