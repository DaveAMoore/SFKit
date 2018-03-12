//
//  SFTableViewHeaderFooterView.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@available(*, deprecated, message: "use UITableViewHeaderFooterView instead")
open class SFTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        registerForAppearanceUpdates()
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        registerForAppearanceUpdates()
    }
}
