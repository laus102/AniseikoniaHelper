//
//  Router.swift
//  iEye
//
//  Created by Brendan Lau on 1/26/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit


class Router: NSObject {
   
   let window: UIWindow
   let storyboard: UIStoryboard
   let navigationController: UINavigationController
   
   fileprivate let _testSelectVC: TestSelectViewController
   fileprivate let _horizontalTestVC: HorizontalTestViewController
   fileprivate let _verticalTestVC: VerticalTestViewController
   
   init(window: UIWindow, storyboard: UIStoryboard) {
      self.window = window
      self.storyboard = storyboard
      
      _testSelectVC = storyboard.instantiateViewController(withIdentifier: "TestSelectViewController") as! TestSelectViewController
      _horizontalTestVC = storyboard.instantiateViewController(withIdentifier: "HorizontalTestViewController") as! HorizontalTestViewController
      _verticalTestVC = storyboard.instantiateViewController(withIdentifier: "VerticalTestViewController") as! VerticalTestViewController
      
      self.navigationController = UINavigationController(rootViewController: _testSelectVC)
      super.init()
      
      navigationController.setNavigationBarHidden(true, animated: false)
      navigationController.delegate = self
      
      _testSelectVC.delegate = self
      _horizontalTestVC.delegate = self
      _verticalTestVC.delegate = self
      
      
      window.rootViewController = navigationController
      window.makeKeyAndVisible()
      
      _testSelectVC.fadeTextIn(with: 5.0)
   }
}

extension Router: UINavigationControllerDelegate {
   
   func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
      guard _testSelectVC != viewController else { return }
      navigationController.viewControllers = [_testSelectVC, viewController]
   }
   
   // Tell the navigationController how to animate the transition
   func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      
      let _transitions = TransitionAnimator()
      
      switch fromVC {
         case _testSelectVC: _transitions.transitionType = toVC == _horizontalTestVC ? .horizontal : .vertical
         case _horizontalTestVC: _transitions.transitionType = toVC == _horizontalTestVC ? .vertical : .done
         case _verticalTestVC: _transitions.transitionType = toVC == _horizontalTestVC ? .horizontal : .done
        default: break
      }
      
      return _transitions
   }
}

////////////////////////////////////////////////////////

extension Router: TestSelectViewControllerDelegate {
   
   func toHorizontalButtonPressed(in sender: TestSelectViewController)
      { navigationController.pushViewController(_horizontalTestVC, animated: true) }
   
   func toVerticalButtonPressed(in sender: TestSelectViewController)
      { navigationController.pushViewController(_verticalTestVC, animated: true) }
}

////////////////////////////////////////////////////////

extension Router: HorizontalTestViewControllerDelegate {
   
   func toVerticalButtonPressed(inHorizontalVC sender: HorizontalTestViewController)
      { navigationController.pushViewController(_verticalTestVC, animated: true) }
   
   func toDoneButtonPressed(inHorizontalVC sender: HorizontalTestViewController)
      { navigationController.popToRootViewController(animated: true) }
}

////////////////////////////////////////////////////////

extension Router: VerticalTestViewControllerDelegate {
   
   func toHorizontalButtonPressed(inVerticalVC sender: VerticalTestViewController)
      { navigationController.pushViewController(_horizontalTestVC, animated: true) }
   
   func toDoneButtonPressed(inVerticalVC sender: VerticalTestViewController)
      { navigationController.popToRootViewController(animated: true) }
}

