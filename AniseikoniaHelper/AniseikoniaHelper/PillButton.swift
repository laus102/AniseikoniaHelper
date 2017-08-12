//
//  PillButton.swift
//  AniseikoniaHelper
//
//  Created by Brendan Lau on 1/26/17.
//  Copyright © 2017 Brendan Lau. All rights reserved.
//

import UIKit

class PillButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = min(bounds.width, bounds.height) * 0.5
        layer.cornerRadius = radius
    }

}
