//
//  UIExtensions.swift
//  iEye
//
//  Created by Brendan Lau on 1/23/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import Foundation
import UIKit


extension CGFloat {
    init(rgbValue: Int) {
        self.init(CGFloat(rgbValue)/255.0)
    }
}

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(rgbValue: r), green: CGFloat(rgbValue: g), blue: CGFloat(rgbValue: b), alpha: a)
    }
    
}

