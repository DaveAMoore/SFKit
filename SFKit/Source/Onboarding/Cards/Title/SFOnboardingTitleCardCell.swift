//
//  SFOnboardingTitleCardCell.swift
//  SFKit
//
//  Created by David Moore on 1/29/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

final public class SFOnboardingTitleCardCell: SFTableViewCell {
    
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
    }
}
