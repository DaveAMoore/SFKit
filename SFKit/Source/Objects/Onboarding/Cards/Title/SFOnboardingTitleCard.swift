//
//  SFOnboardingTitleCard.swift
//  SFKit
//
//  Created by David Moore on 1/29/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

final internal class SFOnboardingTitleCard: SFTableViewCell {
    
    /// Label that will present the title.
    @IBOutlet public var titleLabel: UILabel!
    
    /// Label that will present the description.
    @IBOutlet public var detailLabel: UILabel!
    
    /// Image view that will display the image.
    @IBOutlet public var embeddedImageView: UIImageView!
    
    public override func appearanceStyleDidChange(_ newAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(newAppearanceStyle)
        
        // Configure the view coloring.
        backgroundColor = SFColor.white
        titleLabel.textColor = SFColor.black
        detailLabel.textColor = SFColor.black
        embeddedImageView.tintColor = SFColor.blue
        
        // Configure the title label.
        if #available(iOS 11.0, *) {
            titleLabel.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: UIFont.systemFont(ofSize: 40,
                                                                                                         weight: .bold))
            detailLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: 17,
                                                                                                    weight: .regular))
        }
    }
}
