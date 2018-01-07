//
//  SFCollectionReusableView.swift
//  SFKit
//
//  Created by David Moore on 8/5/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

open class SFCollectionReusableView: UICollectionReusableView {
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        registerForAppearanceUpdates()
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        registerForAppearanceUpdates()
    }
}
