//
//  StartUpViewController.swift
//  iEye
//
//  Created by Brendan Lau on 1/17/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController {
    
    @IBOutlet weak private var _titleLabel: UILabel!
    @IBOutlet weak private var _descriptionLabel: UILabel!
    
    let transition = StartToTestAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let temp = NSMutableAttributedString(string: "Welcome to iEye")
        temp.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(11, 4))
        _titleLabel.attributedText = temp
        
        _descriptionLabel.text = "A better way to diagnose Aniseikonia"
        
        _descriptionLabel.alpha = 0
        UIView.animate(withDuration: 2.0) {
            self._descriptionLabel.alpha = 1
        }
        let testSelectVC = storyboard!.instantiateViewController(withIdentifier: "TestSelectViewController") as! TestSelectViewController
        testSelectVC.transitioningDelegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.present(testSelectVC, animated: true, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension StartUpViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                                          source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        return transition
    }
}

