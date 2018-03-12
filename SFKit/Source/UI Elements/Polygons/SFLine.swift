//
//  SFLine.swift
//  SFKit
//
//  Created by David Moore on 3/7/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

/// Straight line that is either horizontal or vertical, with horizontal being the most common. If an angled line is desired, use `SFPolygon` directly.
@IBDesignable
open class SFLine: SFPolygon {
    
    open override var points: [CGPoint] {
        get {
            if bounds.width >= bounds.height {
                return [CGPoint(x: bounds.minX + lineWidth / 2, y: bounds.midY),
                        CGPoint(x: bounds.maxX - lineWidth / 2, y: bounds.midY)]
            } else {
                return [CGPoint(x: bounds.midX, y: bounds.minY + lineWidth / 2),
                        CGPoint(x: bounds.midX, y: bounds.maxY - lineWidth / 2)]
            }
        } set {}
    }
    
    // MARK: - Initialization
    
    public init() {
        super.init(points: [])
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
