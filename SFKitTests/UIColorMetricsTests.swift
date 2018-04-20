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
    
    let relativeHues: [UIColorMetricsHue] = [.red, .orange, .yellow, .green, .tealBlue, .blue, .darkBlue,
                                             .purple, .pink, .white, .extraLightGray, .lightGray, .gray,
                                             .darkGray, .extraDarkGray, .black]
    
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
            for relativeHue in relativeHues {
                let color = colorMetrics.color(forRelativeHue: relativeHue)
                let hue = colorMetrics.relativeHue(forColor: color)
                
                XCTAssertNotNil(hue)
                XCTAssertEqual(relativeHue, hue)
            }
        }
    }
    
    func testColorForColorRelativeToMetrics() {
        for appearanceStyle in appearanceStyles {
            let primaryColorMetrics = UIColorMetrics(forAppearanceStyle: appearanceStyle)
            let oppositeColorMetrics = appearanceStyle == .light ? UIColorMetrics(forAppearanceStyle: .dark) : UIColorMetrics(forAppearanceStyle: .light)
            for relativeHue in relativeHues {
                let color = primaryColorMetrics.color(forRelativeHue: relativeHue)
                let oppositeColor = oppositeColorMetrics.color(forColor: color,
                                                               relativeTo: primaryColorMetrics)
                
                let hue = primaryColorMetrics.relativeHue(forColor: color)
                let oppositeHue = oppositeColorMetrics.relativeHue(forColor: oppositeColor)
                
                XCTAssertNotNil(hue)
                XCTAssertNotNil(oppositeHue)
                XCTAssertEqual(hue, oppositeHue)
            }
        }
    }
}
