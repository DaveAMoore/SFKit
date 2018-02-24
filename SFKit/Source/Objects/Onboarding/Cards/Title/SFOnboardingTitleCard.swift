//
//  SFOnboardingTitleCard.swift
//  SFKit
//
//  Created by David Moore on 1/28/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

open class SFOnboardingTitleCard: SFOnboardingCard {
    
    // MARK: - Properties
    
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
    
    /// Boolean value indicating if the title will be large.
    open var isLargeTitle: Bool
    
    // MARK: - Initialization
    
    /// Initializes a new receiver.
    public init(titleLabel: SFOnboardingLabel, detailLabel: SFOnboardingLabel? = nil, image: UIImage? = nil,
                isLargeTitle: Bool = true, separatorIsHidden: Bool = true) {
        self.titleLabel = titleLabel
        self.detailLabel = detailLabel
        self.image = image
        self.isLargeTitle = isLargeTitle
        self.separatorIsHidden = separatorIsHidden
        super.init()
        self.selectionStyle = .none
    }
    
    // MARK: - Interface
    
    /// Prepares a card for presentation within a table view.
    ///
    /// - Parameter card: Card that must be configured for display.
    open override func prepare(_ card: UITableViewCell, forController controller: SFOnboardingStageViewController?) {
        super.prepare(card, forController: controller)
        
        // Cast the card as the appropriate cell type.
        let card = card as! SFOnboardingTitleCardCell
        
        // Prepare the labels.
        titleLabel?.prepare(card.titleLabel)
        detailLabel?.prepare(card.detailLabel)
        
        // Configure the labeol fonts.
        let titleFont: UIFont
        let detailFont: UIFont
        if #available(iOS 11.0, *) {
            if isLargeTitle {
                titleFont = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: UIFont.systemFont(ofSize: 34, weight: .bold))
            } else {
                titleFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: 24, weight: .bold))
            }
            detailFont = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 17, weight: .regular))
        } else {
            titleFont = UIFont.systemFont(ofSize: isLargeTitle ? 34 : 17, weight: .bold)
            detailFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
        
        // Configure the label fonts.
        card.titleLabel.font = titleFont
        card.detailLabel.font = detailFont
        
        // Set the image.
        card.embeddedImageView.image = image
        
        // Configure the separator.
        if separatorIsHidden {
            card.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        } else {
            card.separatorInset = .zero
        }
        
        // Hide/show the card's elements, depending on their optionality.
        card.embeddedImageView.isHidden = image == nil
        card.titleLabel.isHidden = titleLabel == nil
        card.detailLabel.isHidden = detailLabel == nil
    }
}
