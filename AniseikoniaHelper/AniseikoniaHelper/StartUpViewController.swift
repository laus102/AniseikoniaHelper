//
//  StartUpViewController.swift
//  AniseikoniaHelper
//
//  Created by Brendan Lau on 1/17/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController {
    
    @IBOutlet weak private var _titleLabel: UILabel!
    @IBOutlet weak private var _descriptionLabel: UILabel!

    let transition = TransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        
        let temp = NSMutableAttributedString(string: "Welcome to AniseikoniaHelper")
        temp.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(11, 4))
        
        _titleLabel.attributedText = temp
        _descriptionLabel.text = "A better way to diagnose Aniseikonia"
        _descriptionLabel.alpha = 0
    }
    
    func fadeTextIn(with duration: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: { 
            self._descriptionLabel.alpha = 1
        }) { (finished) in
            completion?()
        }
    }
}

extension StartUpViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                                          source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        return transition
    }
}



