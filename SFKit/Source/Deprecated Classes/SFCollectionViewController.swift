//
//  SFCollectionViewController.swift
//  SFKit
//
//  Created by David Moore on 7/01/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

@available(*, deprecated, message: "use UICollectionViewController instead")
open class SFCollectionViewController: UICollectionViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        registerForAppearanceUpdates()
    }
}
