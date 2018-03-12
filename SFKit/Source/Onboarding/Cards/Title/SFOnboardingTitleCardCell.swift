//
//  SFOnboardingTitleCardCell.swift
//  SFKit
//
//  Created by David Moore on 1/29/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

final public class SFOnboardingTitleCardCell: UITableViewCell {
    
    /// Label that will present the title.
    @IBOutlet public var titleLabel: UILabel!
    
    /// Label that will present the description.
    @IBOutlet public var detailLabel: UILabel!
    
    /// Image view that will display the image.
    @IBOutlet public var embeddedImageView: UIImageView!
    
    public override func appearanceStyleDidChange(_ previousAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(previousAppearanceStyle)
        
        // Configure the view coloring.
        let colorMetrics = UIColorMetrics(forAppearance: appearance)
        backgroundColor = colorMetrics.color(forRelativeHue: .white)
        titleLabel.textColor = colorMetrics.color(forRelativeHue: .black)
        detailLabel.textColor = colorMetrics.color(forRelativeHue: .black)
        embeddedImageView.tintColor = colorMetrics.color(forRelativeHue: .blue)
    }
}
