//
//  PillLabel.swift
//  iEye
//
//  Created by Brendan Lau on 1/19/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class PillLabel: UILabel {

    let topInset = CGFloat(-15.0), bottomInset = CGFloat(-15.0), leftInset = CGFloat(-15.0), rightInset = CGFloat(-15.0)

    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = min(bounds.width, bounds.height) * 0.2
        layer.cornerRadius = radius
    }
    
    
//    override func drawText(in rect: CGRect) {
//        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
//    }
    
//    override var intrinsicContentSize: CGSize {
//        var intrinsicSuperViewContentSize = super.intrinsicContentSize
//        intrinsicSuperViewContentSize.height = 80.0
//        intrinsicSuperViewContentSize.width = 200.0
//        return intrinsicSuperViewContentSize
//    }
}


