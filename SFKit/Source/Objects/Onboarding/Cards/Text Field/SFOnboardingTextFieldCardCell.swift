//
//  SFOnboardingTextFieldCardCell.swift
//  SFKit
//
//  Created by David Moore on 1/29/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

final internal class SFOnboardingTextFieldCardCell: SFTableViewCell {
    
    /// Label that will present the title.
    @IBOutlet public var titleLabel: UILabel!
    
    /// Text field from which input will be taken.
    @IBOutlet public var textField: UITextField!
    
    public override func appearanceStyleDidChange(_ newAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(newAppearanceStyle)
        
        // Configure the view coloring.
        backgroundColor = SFColor.white
        titleLabel.textColor = SFColor.black
        textField.textColor = SFColor.black
    }
}
