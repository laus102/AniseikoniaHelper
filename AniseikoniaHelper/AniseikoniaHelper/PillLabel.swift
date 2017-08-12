//
//  PillLabel.swift
//  AniseikoniaHelper
//
//  Created by Brendan Lau on 1/26/17.
//  Copyright © 2017 Brendan Lau. All rights reserved.
//

import UIKit

class PillLabel: UILabel {

    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = min(bounds.width, bounds.height) * 0.2
        layer.cornerRadius = radius
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height = 45.0
        intrinsicSuperViewContentSize.width = 100.0
        return intrinsicSuperViewContentSize
    }
}


