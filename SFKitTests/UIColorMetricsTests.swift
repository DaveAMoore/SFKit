//
//  UIColorMetricsTests.swift
//  SFKitTests
//
//  Created by David Moore on 4/14/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

import XCTest
@testable import SFKit

class UIColorMetricsTests: XCTestCase {
    
    // MARK: - Properties
    
    let appearanceStyles: [SFAppearanceStyle] = [.light, .dark]
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testRelativeHueForColor() {
        for appearanceStyle in appearanceStyles {
            let colorMetrics = UIColorMetrics(forAppearanceStyle: appearanceStyle)
            for hue in UIColorMetrics.Hue.allCases {
                guard hue != .none else { continue }
                
                let color = colorMetrics.relativeColor(for: hue)
                let relativeHue = colorMetrics.relativeHue(for: color)
                
                XCTAssertNotEqual(relativeHue, .none)
                XCTAssertEqual(hue, relativeHue)
            }
        }
    }
}
