//
//  SFPolygon.swift
//  SFKit
//
//  Created by David Moore on 3/7/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

open class SFPolygon: SFView {
    
    // MARK: - Line Dash
    
    public struct LineDash {
        public var phase: CGFloat
        public var lengths: [CGFloat]
    }
    
    // MARK: - Properties
    
    /// Collection of vertices that will be drawn.
    open var points: [CGPoint] {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    /// Stroke color of the resulting polygon line.
    @IBInspectable
    open var strokeColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// Line width of the resultant polygon.
    @IBInspectable
    open var lineWidth: CGFloat = 2.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    /// Line join of the resultant polygon.
    open var lineJoin: CGLineJoin = .miter {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// Line cap of the resultant polygon.
    open var lineCap: CGLineCap = .butt {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// Optional line dash structure value that defines the line dash for the line.
    open var lineDash: LineDash? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// Path of the resultant polygon.
    open var path: CGPath {
        // Create a mutable path.
        let path = CGMutablePath()
        
        // In the case where there are no points, simply return the mutable path as-is.
        guard !points.isEmpty else {
            return path
        }
        
        // Add lines connecting the points.
        path.addLines(between: points)
        
        return path
    }
    
    /// Normalized version of `path` that has coordinates which are in the appropriate coordinate system of the receiver. The value of `normalizedPath` may be `nil` in the case where `points` is *empty*.
    open var normalizedPath: CGPath? {
        // Determine the minimum point in the array.
        guard let minPoint = points.min(by: { $0.x <= $1.x && $0.y <= $1.y }) else { return nil }
        
        // Create a transform for the path.
        var transform = CGAffineTransform(translationX: -minPoint.x, y: -minPoint.y)
        transform = transform.translatedBy(x: lineWidth / 2, y: lineWidth / 2)
        
        // Copy the path while transforming it.
        return path.copy(using: &transform)!
    }
    
    /// Intrinsic content size of the resultant polygon.
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: path.boundingBoxOfPath.size.width + lineWidth,
                      height: path.boundingBoxOfPath.size.height + lineWidth)
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        self.points = []
        super.init(frame: frame)
    }
    
    public init(points: [CGPoint]) {
        self.points = points
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.strokeColor = UIColorMetrics(forAppearance: appearance).color(forRelativeHue: .lightGray)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.points = []
        super.init(coder: aDecoder)
    }
    
    // MARK: - Sizing
    
    open override func sizeToFit() {
        // Use the intrinsic content size.
        frame.size = intrinsicContentSize
    }
    
    // MARK: - Drawing
    
    open override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
    
        // Unwrap the normalized path.
        guard let normalizedPath = normalizedPath else { return }
        
        // Request the polygon be drawn.
        drawPolygon(normalizedPath, in: rect, with: context)
    }
    
    private func drawPolygon(_ path: CGPath, in rect: CGRect, with context: CGContext) {
        // Add the path to the context.
        context.addPath(path)
        
        // Determine the appropriate stroke color and apply it to the context.
        let strokeColor = self.strokeColor ?? .clear
        context.setStrokeColor(strokeColor.cgColor)
        
        // Configure the path properties.
        context.setLineWidth(lineWidth)
        context.setLineJoin(.bevel)
        context.setLineCap(.round)
        
        // Unwrap the line dash structure and use it to configure any line dash properties.
        if let lineDash = lineDash {
            context.setLineDash(phase: lineDash.phase, lengths: lineDash.lengths)
        }
        
        // Ask the context to draw the path.
        context.drawPath(using: .stroke)
    }
}
