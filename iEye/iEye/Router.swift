//
//  Router.swift
//  iEye
//
//  Created by Brendan Lau on 1/26/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class Router {
    
    let window: UIWindow
    fileprivate let _startUpVC: StartUpViewController
    fileprivate let _testSelectVC: TestSelectViewController
    fileprivate let _horizontalTestVC: HorizontalTestViewController
    fileprivate let _verticalTestVC: VerticalTestViewController
    
    init(window: UIWindow, storyboard: UIStoryboard) {
        self.window = window
        _startUpVC = storyboard.instantiateViewController(withIdentifier: "StartUpViewController") as! StartUpViewController
        _testSelectVC = storyboard.instantiateViewController(withIdentifier: "TestSelectViewController") as! TestSelectViewController
        
        _horizontalTestVC = storyboard.instantiateViewController(withIdentifier: "HorizontalTestViewController") as! HorizontalTestViewController
        _verticalTestVC = storyboard.instantiateViewController(withIdentifier: "VerticalTestViewController") as! VerticalTestViewController
        
        _testSelectVC.delegate? = self
        _testSelectVC.modalTransitionStyle = .crossDissolve
        _testSelectVC.modalPresentationStyle = .overCurrentContext
        
        _horizontalTestVC.delegate? = self
        _verticalTestVC.delegate? = self
        
        window.rootViewController = _startUpVC
        window.makeKeyAndVisible()
        
        _startUpVC.fadeTextIn(with: 5.0) {
            self._startUpVC.present(self._testSelectVC, animated: true, completion: nil)
        }
    }
}

// Combine test VCs

extension Router: TestSelectViewControllerDelegate {
    func toHorizontalButtonPressed(in sender: TestSelectViewController) {
        sender.dismiss(animated: true) {
            self._testSelectVC.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }
    }
    func toVerticalButtonPressed(in sender: TestSelectViewController) {
        
    }
}

extension Router: HorizontalTestViewControllerDelegate {
    func toDoneButtonPressed(in sender: HorizontalTestViewController) {
        
    }
    
    func toVerticalButtonPressed(in sender: HorizontalTestViewController) {
        
    }
}

extension Router: VerticalTestViewControllerDelegate {
    func toHorizontalButtonPressed(in sender: VerticalTestViewController) {
        
    }
    func toDoneButtonPressed(in sender: VerticalTestViewController) {
        
    }
}
