//
//  SplashScreen.swift
//  iEye
//
//  Created by Brendan Lau on 1/27/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class SplashScreen: UIView {
    
    weak private var _titleLabel: UILabel!
    weak private var _descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); didLoad() }
    override func layoutSubviews() { super.layoutSubviews() }
    override func updateConstraints() { super.updateConstraints(); translatesAutoresizingMaskIntoConstraints = false }
    
    func didLoad() {
    
        let temp = NSMutableAttributedString(string: "Welcome to iEye")
        temp.addAttribute(NSForegroundColorAttributeName, value: UIColor.uiRed, range: NSMakeRange(11, 4))
        
        _titleLabel.attributedText = temp
        _titleLabel.font = UIFont(name: "System", size: 70.0)
        _titleLabel.minimumScaleFactor = 10.0/70.0
        _titleLabel.alpha = 1.0
        
        _descriptionLabel.text = "A better way to diagnose Aniseikonia"
        _descriptionLabel.font = UIFont(name: "System Italic", size: 19.0)
        _descriptionLabel.minimumScaleFactor = 10.0 / 19.0
        _descriptionLabel.alpha = 0.0
        
        // Constraints
        _titleLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor)
        _descriptionLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor)
        _titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: self.bounds.maxY / 6.0)
        _descriptionLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 31.0)
    }
    

    func fadeTextIn(with duration: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self._descriptionLabel.alpha = 1
        }) { (finished) in
            completion?()
        }
    }
}
