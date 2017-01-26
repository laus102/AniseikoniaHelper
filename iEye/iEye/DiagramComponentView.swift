//
//  DiagramComponentView.swift
//  iEye
//
//  Created by Brendan Lau on 1/23/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit



struct DiagramMeasurements {
    
    let bounds: CGRect
    var boundsTopLeft: CGPoint { return CGPoint(x: bounds.minX, y: bounds.minY) }
    var boundsMiddleLeft: CGPoint { return CGPoint(x: bounds.minX, y: bounds.maxY/2.0) }
    var boundsBottomLeft: CGPoint { return CGPoint(x: bounds.minX, y: bounds.maxY) }
    var boundsTopRight: CGPoint { return CGPoint(x: bounds.maxX, y: bounds.minY) }
    var boundsBottomRight: CGPoint { return CGPoint(x: bounds.maxX, y: bounds.maxY) }
    
    var whole: (x: CGFloat, y: CGFloat) { return (x: bounds.maxX, y: bounds.maxY) }
    var half: (x: CGFloat, y: CGFloat) { return (x: bounds.maxX/2.0, y: bounds.maxY/2.0) }

    var big: (xHash: CGFloat, yHalf: CGFloat, ySpacing: CGFloat)
        { return (xHash: bounds.maxX * 0.75, yHalf: half.y * 0.60, ySpacing: (half.y * 0.60)/4.0) }
    
    var small: (xHash: CGFloat, yHalf: CGFloat, ySpacing: CGFloat)
        { return (xHash: whole.x / 8.0, yHalf: half.y - big.yHalf, ySpacing: (half.y - big.yHalf)/6.0) }
}



class DiagramComponentView: UIView {
    
    var fillColor: UIColor = UIColor.black { didSet { setNeedsDisplay() } }
    
    private func addOutlineLines(context: CGContext, measurements: DiagramMeasurements) -> () {
        context.move(to: measurements.boundsTopRight)
        context.addLine(to: measurements.boundsTopLeft)
        context.addLine(to: measurements.boundsBottomLeft)
        context.addLine(to: measurements.boundsBottomRight)
    }
    
    private func addBigHashLines(context: CGContext, measurements: DiagramMeasurements) -> () {
        
        var topStartPoint = measurements.boundsTopLeft, bottomStartPoint = measurements.boundsBottomLeft
        
        for _ in 0..<4 {
            topStartPoint = CGPoint(x: topStartPoint.x, y: topStartPoint.y + measurements.big.ySpacing)
            bottomStartPoint = CGPoint(x: bottomStartPoint.x, y: bottomStartPoint.y - measurements.big.ySpacing)
            context.move(to: topStartPoint)
            context.addLine(to: CGPoint(x: topStartPoint.x + measurements.big.xHash, y: topStartPoint.y))
            context.move(to: bottomStartPoint)
            context.addLine(to: CGPoint(x: bottomStartPoint.x + measurements.big.xHash, y: bottomStartPoint.y))
        }
    }
    
    private func addSmallHashLines(context: CGContext, measurements: DiagramMeasurements) -> () {
        
        var topStartPoint = measurements.boundsMiddleLeft, bottomStartPoint = measurements.boundsMiddleLeft
        
        for _ in 0..<4 {
            topStartPoint = CGPoint(x: topStartPoint.x, y: topStartPoint.y - measurements.small.ySpacing)
            bottomStartPoint = CGPoint(x: bottomStartPoint.x, y: bottomStartPoint.y + measurements.small.ySpacing)
            context.move(to: topStartPoint)
            context.addLine(to: CGPoint(x: topStartPoint.x + measurements.small.xHash, y: topStartPoint.y))
            context.move(to: bottomStartPoint)
            context.addLine(to: CGPoint(x: bottomStartPoint.x + measurements.small.xHash, y: bottomStartPoint.y))
        }
    }
    
    private func generateCenterCircle(context: CGContext, measurements: DiagramMeasurements) -> CGRect {
        fillColor.setFill()
        let circleDiameter = measurements.small.ySpacing / 2.0
        let origin =  CGPoint(x: measurements.boundsMiddleLeft.x - circleDiameter/2.0,
                              y: measurements.boundsMiddleLeft.y - circleDiameter/2.0)
        return CGRect(origin: origin, size: CGSize(width: circleDiameter, height: circleDiameter))
    }
    
    override func draw(_ rect: CGRect) {
        clipsToBounds = true
        UIColor.white.setFill()
        UIRectFill(rect)
        
        let lineWidth: CGFloat = 3.0
        let diagramMeasurements = DiagramMeasurements(bounds: bounds.insetBy(dx: lineWidth/2.0, dy: lineWidth/2.0))
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(fillColor.cgColor)
            context.setAlpha(1.0)
            context.setLineWidth(lineWidth)
            // Add the lines
            addOutlineLines(context: context, measurements: diagramMeasurements)
            addBigHashLines(context: context, measurements: diagramMeasurements)
            addSmallHashLines(context: context, measurements: diagramMeasurements)
            // Draw it
            context.strokePath()
            // Add the circle
            context.fillEllipse(in: generateCenterCircle(context: context, measurements: diagramMeasurements))
        }
    }
    
    func adjust(scale: CGFloat, rotation: CGFloat) ->() {
        transform = rotation < 0 ? CGAffineTransform(scaleX: -scale, y: scale) : CGAffineTransform(scaleX: scale, y: scale)
    }
    
}
