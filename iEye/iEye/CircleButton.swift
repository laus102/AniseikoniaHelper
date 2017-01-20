//
//  CircleButton.swift
//  iEye
//
//  Created by Brendan Lau on 1/19/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = min(bounds.width, bounds.height) * 0.5
    }
}
