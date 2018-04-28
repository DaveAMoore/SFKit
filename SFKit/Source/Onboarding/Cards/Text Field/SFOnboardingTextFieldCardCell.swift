//
//  SFOnboardingTextFieldCardCell.swift
//  SFKit
//
//  Created by David Moore on 1/29/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

final public class SFOnboardingTextFieldCardCell: UITableViewCell {
    
    /// Label that will present the title.
    @IBOutlet public var titleLabel: UILabel!
    
    /// Text field from which input will be taken.
    @IBOutlet public var textField: UITextField!
    
    public override func appearanceStyleDidChange(_ previousAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(previousAppearanceStyle)
        
        // Configure the view coloring.
        let colorMetrics = UIColorMetrics(forAppearance: appearance)
        backgroundColor = colorMetrics.color(forRelativeHue: .white)
        titleLabel.textColor = colorMetrics.color(forRelativeHue: .black)
        textField.textColor = colorMetrics.color(forRelativeHue: .black)
        if let placeholder = textField.placeholder {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColorMetrics(forAppearance: appearance).color(forRelativeHue: .lightGray)])
        }
    }
}
