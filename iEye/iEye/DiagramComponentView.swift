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
    var boundsMiddleBottom: CGPoint { return CGPoint(x: bounds.maxX/2.0, y: bounds.maxY) }
    var boundsBottomLeft: CGPoint { return CGPoint(x: bounds.minX, y: bounds.maxY) }
    var boundsTopRight: CGPoint { return CGPoint(x: bounds.maxX, y: bounds.minY) }
    var boundsBottomRight: CGPoint { return CGPoint(x: bounds.maxX, y: bounds.maxY) }
    
    var whole: (x: CGFloat, y: CGFloat) { return (x: bounds.maxX, y: bounds.maxY) }
    var half: (x: CGFloat, y: CGFloat) { return (x: bounds.maxX/2.0, y: bounds.maxY/2.0) }

    var big: (hash: CGFloat, half: CGFloat, hashSpacing: CGFloat) {
        return bounds.maxY > bounds.maxX
            // Vertical Diagram
            ? (hash: bounds.maxX * 0.75, half: half.y * 0.60, hashSpacing: (half.y * 0.60)/4.0)
            // Horizontal Diagram
            : (hash: bounds.maxY * 0.75, half: half.x * 0.60, hashSpacing: (half.x * 0.60)/4.0)
    }
    
    var small: (hash: CGFloat, half: CGFloat, hashSpacing: CGFloat) {
        return bounds.maxY > bounds.maxX
            // Vertical Diagram
            ? (hash: whole.x / 8.0, half: half.y - big.half, hashSpacing: (half.y - big.half)/6.0)
            // Horizontal Diagram
            : (hash: whole.y / 8.0, half: half.x - big.half, hashSpacing: (half.x - big.half)/6.0)
    }
}



class DiagramComponentView: UIView {

    var fillColor: UIColor = UIColor.clear { didSet { setNeedsDisplay() } }
    
    private func addOutlineLines(context: CGContext, measurements: DiagramMeasurements) -> () {
        if bounds.maxY > bounds.maxX { // Vertical Diagram
            context.move(to: measurements.boundsTopRight)
            context.addLine(to: measurements.boundsTopLeft)
            context.addLine(to: measurements.boundsBottomLeft)
            context.addLine(to: measurements.boundsBottomRight)
        }
            
        else { // Horizontal Diagram
            context.move(to: measurements.boundsTopLeft)
            context.addLine(to: measurements.boundsBottomLeft)
            context.addLine(to: measurements.boundsBottomRight)
            context.addLine(to: measurements.boundsTopRight)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    private func addBigHashLines(context: CGContext, measurements: DiagramMeasurements) -> () {
        
        var topStartPoint = bounds.maxY > bounds.maxX ? measurements.boundsTopLeft : measurements.boundsBottomLeft
        var bottomStartPoint = bounds.maxY > bounds.maxX ? measurements.boundsBottomLeft : measurements.boundsBottomRight
        
        if bounds.maxY > bounds.maxX { // Vertical Diagram
            for _ in 0..<4 {
                topStartPoint = CGPoint(x: topStartPoint.x, y: topStartPoint.y + measurements.big.hashSpacing)
                bottomStartPoint = CGPoint(x: bottomStartPoint.x, y: bottomStartPoint.y - measurements.big.hashSpacing)
                context.move(to: topStartPoint)
                context.addLine(to: CGPoint(x: topStartPoint.x + measurements.big.hash, y: topStartPoint.y))
                context.move(to: bottomStartPoint)
                context.addLine(to: CGPoint(x: bottomStartPoint.x + measurements.big.hash, y: bottomStartPoint.y))
            }
        }
            
        else { // Horizontal Diagram
            for _ in 0..<4 {
                topStartPoint = CGPoint(x: topStartPoint.x + measurements.big.hashSpacing, y: topStartPoint.y)
                bottomStartPoint = CGPoint(x: bottomStartPoint.x - measurements.big.hashSpacing, y: bottomStartPoint.y)
                context.move(to: topStartPoint)
                context.addLine(to: CGPoint(x: topStartPoint.x, y: topStartPoint.y - measurements.big.hash))
                context.move(to: bottomStartPoint)
                context.addLine(to: CGPoint(x: bottomStartPoint.x, y: bottomStartPoint.y - measurements.big.hash))
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    private func addSmallHashLines(context: CGContext, measurements: DiagramMeasurements) -> () {
        
        var topStartPoint = bounds.maxY > bounds.maxX ? measurements.boundsMiddleLeft : measurements.boundsMiddleBottom
        var bottomStartPoint = bounds.maxY > bounds.maxX ? measurements.boundsMiddleLeft : measurements.boundsMiddleBottom
        
        if bounds.maxY > bounds.maxX { // Vertical Diagram
            for _ in 0..<4 {
                topStartPoint = CGPoint(x: topStartPoint.x, y: topStartPoint.y - measurements.small.hashSpacing)
                bottomStartPoint = CGPoint(x: bottomStartPoint.x, y: bottomStartPoint.y + measurements.small.hashSpacing)
                context.move(to: topStartPoint)
                context.addLine(to: CGPoint(x: topStartPoint.x + measurements.small.hash, y: topStartPoint.y))
                context.move(to: bottomStartPoint)
                context.addLine(to: CGPoint(x: bottomStartPoint.x + measurements.small.hash, y: bottomStartPoint.y))
            }
        }
        else { // Horizontal Diagram
            for _ in 0..<4 {
                topStartPoint = CGPoint(x: topStartPoint.x - measurements.small.hashSpacing, y: topStartPoint.y)
                bottomStartPoint = CGPoint(x: bottomStartPoint.x + measurements.small.hashSpacing, y: bottomStartPoint.y)
                context.move(to: topStartPoint)
                context.addLine(to: CGPoint(x: topStartPoint.x, y: topStartPoint.y - measurements.small.hash))
                context.move(to: bottomStartPoint)
                context.addLine(to: CGPoint(x: bottomStartPoint.x, y: bottomStartPoint.y - measurements.small.hash))
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    private func generateCenterCircle(context: CGContext, measurements: DiagramMeasurements) -> CGRect {
        fillColor.setFill()
        let circleDiameter = measurements.small.hashSpacing / 2.0
        let origin =  bounds.maxY > bounds.maxX
            ? CGPoint(x: measurements.boundsMiddleLeft.x - circleDiameter/2.0, y: measurements.boundsMiddleLeft.y - circleDiameter/2.0)
            : CGPoint(x: measurements.boundsMiddleBottom.x - circleDiameter/2.0, y: measurements.boundsMiddleBottom.y - circleDiameter/2.0)
        return CGRect(origin: origin, size: CGSize(width: circleDiameter, height: circleDiameter))
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    override func draw(_ rect: CGRect) {
        
        clipsToBounds = true

        UIColor.clear.setFill()
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
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func adjust(scale: CGFloat, diagramOrientation: DiagramDirection) ->() {
        switch diagramOrientation {
            case .left: transform = CGAffineTransform(scaleX: -scale, y: scale)
            case .right: transform = CGAffineTransform(scaleX: scale, y: scale)
            case .bottom: transform = CGAffineTransform(scaleX: scale, y: -scale)
            case .top: transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
}
