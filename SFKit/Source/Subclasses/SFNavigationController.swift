//
//  SFNavigationController.swift
//  SFKit
//
//  Created by David Moore on 8/6/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

import UIKit

open class SFNavigationController: UINavigationController {
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        registerForAppearanceUpdates()
    }
    
    // MARK: - Initialization
    
    public override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: SFNavigationBar.self, toolbarClass: nil)
        setViewControllers([rootViewController], animated: false)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
