//
//  SFOnboardingTitleCard.swift
//  SFKit
//
//  Created by David Moore on 1/28/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

open class SFOnboardingTitleCard: SFOnboardingCard {
    
    /// Type of cell that will be created for the card.
    open override var cellType: UITableViewCell.Type {
        return SFOnboardingTitleCardCell.self
    }
    
    /// The title label element. Title will be displayed beneath the `image` `UIImageView`.
    open var titleLabel: SFOnboardingLabel?
    
    /// The label element that corresponds to the presentation of a descriptive string. Will be presented beneath the `localizedTitle` in the label.
    open var detailLabel: SFOnboardingLabel?
    
    /// Image will be displayed above the `localizedTitle` label.
    open var image: UIImage?
    
    /// Boolean value indicating if the separator will be hidden on the card.
    open var separatorIsHidden: Bool
    
    /// Initializes a new receiver.
    @available(iOS, unavailable, message: "use 'init(titleLabel:detailLabel:image:separatorIsHidden)' instead")
    public init(localizedTitle: String, localizedDescription: String? = nil, image: UIImage? = nil,
                separatorIsHidden: Bool = true) {
        self.image = image
        self.separatorIsHidden = separatorIsHidden
    }
    
    /// Initializes a new receiver.
    public init(titleLabel: SFOnboardingLabel, detailLabel: SFOnboardingLabel? = nil, image: UIImage? = nil,
                separatorIsHidden: Bool = true) {
        self.titleLabel = titleLabel
        self.detailLabel = detailLabel
        self.image = image
        self.separatorIsHidden = separatorIsHidden
    }
    
    /// Prepares a card for presentation within a table view.
    ///
    /// - Parameter card: Card that must be configured for display.
    open override func prepare(_ card: UITableViewCell, forController controller: SFOnboardingStageViewController?) {
        let card = card as! SFOnboardingTitleCardCell
        titleLabel?.prepare(card.titleLabel)
        detailLabel?.prepare(card.detailLabel)
        card.titleLabel.isHidden = titleLabel == nil
        card.detailLabel.isHidden = detailLabel == nil
        card.embeddedImageView.image = image
        card.separatorInset = separatorIsHidden ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude) : UIEdgeInsets(top: 0, left: card.layoutMargins.left, bottom: 0, right: 0)
    }
}
