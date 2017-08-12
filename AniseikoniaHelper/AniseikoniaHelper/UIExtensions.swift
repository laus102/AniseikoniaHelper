//
//  UIExtensions.swift
//  AniseikoniaHelper
//
//  Created by Brendan Lau on 1/26/17.
//  Copyright © 2017 Brendan Lau. All rights reserved.
//

import Foundation
import UIKit


enum DiagramDirection: String {
    case left = "Left"
    case right = "Right"
    case bottom = "Bottom"
    case top = "Top"
    
    var next: DiagramDirection {
        switch self {
            case .left: return .right
            case .right: return .left
            case .bottom: return .top
            case .top: return .bottom
        }
    }
}

extension CGFloat {
    init(rgbValue: Int) {
        self.init(CGFloat(rgbValue)/255.0)
    }
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(rgbValue: r), green: CGFloat(rgbValue: g), blue: CGFloat(rgbValue: b), alpha: a)
    }
    open class var iEyeGreen: UIColor { return UIColor(r: 142, g: 255, b: 131, a: 1.0) }
    open class var iEyeRed: UIColor { return UIColor(r: 255, g: 142, b: 103, a: 1.0) }
    open class var uiRed: UIColor { return UIColor(r: 200, g: 32, b: 30, a: 1.0) }
    open class var lightUIRed: UIColor { return UIColor(r: 200, g: 32, b: 30, a: 0.1) }
    open class var iEyeLightGray: UIColor { return UIColor(white: 0.667, alpha: 0.5) }
}


