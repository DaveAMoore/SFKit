//
//  SFOnboardingLabel.swift
//  SFKit
//
//  Created by David Moore on 2/2/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

open class SFOnboardingLabel: SFOnboardingElement {
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    public override init(localizedTitle: String) {
        super.init(localizedTitle: localizedTitle)
    }
    
    // MARK: - Preparation
    
    /// Configures the `text` property of a `UILabel` with `localizedTitle`.
    ///
    /// - Parameter label: Label that will have its `text` property configured.
    open func prepare(_ label: UILabel) {
        label.text = localizedTitle
        label.adjustsFontForContentSizeCategory = true
    }
}
