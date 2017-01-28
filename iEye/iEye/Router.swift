//
//  Router.swift
//  iEye
//
//  Created by Brendan Lau on 1/26/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit


struct iEyeTransition {
    var leftToRight: CATransition {
        let trans = CATransition()
        trans.duration = 0.5
        trans.type = "push"
        trans.subtype = "fromLeft"
        return trans
    }
    
    var bottomToTop: CATransition {
        let trans = CATransition()
        trans.duration = 0.5
        trans.type = "push"
        trans.subtype = "fromBottom"
        return trans
    }
}

////////////////////////////////////

class Router {
    
    let window: UIWindow

    fileprivate let _testSelectVC: TestSelectViewController
    fileprivate let _horizontalTestVC: HorizontalTestViewController
    fileprivate let _verticalTestVC: VerticalTestViewController
    let _transitions = iEyeTransition()
    
    init(window: UIWindow, storyboard: UIStoryboard) {
        self.window = window
        
        // ** Combine test VCs **
        
        _testSelectVC = storyboard.instantiateViewController(withIdentifier: "TestSelectViewController") as! TestSelectViewController
        _horizontalTestVC = storyboard.instantiateViewController(withIdentifier: "HorizontalTestViewController") as! HorizontalTestViewController
        _verticalTestVC = storyboard.instantiateViewController(withIdentifier: "VerticalTestViewController") as! VerticalTestViewController
        
        _testSelectVC.delegate = self
        _horizontalTestVC.delegate = self
        _verticalTestVC.delegate = self
        
        window.rootViewController = _testSelectVC
        window.makeKeyAndVisible()
        
        _testSelectVC.fadeTextIn(with: 5.0)
    }
}

////////////////////////////////////////////////////////

extension Router: TestSelectViewControllerDelegate {
    
    func toHorizontalButtonPressed(in sender: TestSelectViewController) {
        window.layer.add(_transitions.leftToRight, forKey: "leftToRight")
        self._testSelectVC.present(self._horizontalTestVC, animated: true, completion: nil)
    }
    
    func toVerticalButtonPressed(in sender: TestSelectViewController) {
        window.layer.add(_transitions.bottomToTop, forKey: "topToBottom")
        self._testSelectVC.present(self._verticalTestVC, animated: true, completion: nil)
    }
    
}

////////////////////////////////////////////////////////

extension Router: HorizontalTestViewControllerDelegate {
    
    func toDoneButtonPressed(in sender: HorizontalTestViewController) {
        sender.dismiss(animated: true, completion: nil)
    }
    
    func toVerticalButtonPressed(in sender: HorizontalTestViewController) {
        sender.dismiss(animated: true) {
            self.window.layer.add(self._transitions.bottomToTop, forKey: "topToBottom")
            self.window.rootViewController?.present(self._verticalTestVC, animated: true, completion: nil)
        }
    }
}

////////////////////////////////////////////////////////

extension Router: VerticalTestViewControllerDelegate {
    
    func toHorizontalButtonPressed(in sender: VerticalTestViewController) {
        window.layer.add(_transitions.leftToRight, forKey: "leftToRight")
        sender.dismiss(animated: true) {
            self.window.rootViewController?.present(self._horizontalTestVC, animated: true, completion: nil)
        }
    }
    
    func toDoneButtonPressed(in sender: VerticalTestViewController) {
        sender.dismiss(animated: true, completion: nil)
    }
}
