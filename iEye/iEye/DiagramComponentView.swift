//
//  DiagramComponentView.swift
//  iEye
//
//  Created by Brendan Lau on 1/23/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class DiagramComponentView: UIView {
    
    var fillColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
//        let context = UIGraphicsGetCurrentContext()
//        print(context?.beginPath())
        fillColor.setFill()
        UIRectFill(rect)
    }
    
    func adjust(scale: CGFloat) ->() {
        transform = CGAffineTransform(scaleX: scale, y: scale)
    }
 
}
