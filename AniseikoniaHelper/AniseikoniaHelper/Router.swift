//
//  Router.swift
//  AniseikoniaHelper
//
//  Created by Brendan Lau on 1/26/17.
//  Copyright © 2017 Brendan Lau. All rights reserved.
//

import UIKit


class Router: NSObject {

    let window: UIWindow
    let storyboard: UIStoryboard
    let navigationController: UINavigationController

    fileprivate let _horizontalTestVC: HorizontalTestViewController
    fileprivate let _verticalTestVC: VerticalTestViewController

    init(window: UIWindow, storyboard: UIStoryboard) {
        self.window = window
        self.storyboard = storyboard

        _horizontalTestVC = storyboard.instantiateViewController(withIdentifier: "HorizontalTestViewController") as! HorizontalTestViewController
        _verticalTestVC = storyboard.instantiateViewController(withIdentifier: "VerticalTestViewController") as! VerticalTestViewController

        self.navigationController = UINavigationController(rootViewController: _verticalTestVC)
        super.init()

        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.delegate = self
        _horizontalTestVC.delegate = self
        _verticalTestVC.delegate = self

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        _verticalTestVC.displayAndDismissSplashScreenWith(DescriptionFadeIn: 2.5, splashFadeOut: 1.0, testFadeIn: 1.0)
    }
}

extension Router: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        let _transitions = TransitionAnimator()

        switch fromVC {
            case _horizontalTestVC: _transitions.transition = toVC == _verticalTestVC ? .vertical : .doneHorizontal
            case _verticalTestVC: _transitions.transition = toVC == _horizontalTestVC ? .horizontal : .doneVertical
          default: break
        }

        return _transitions
    }
}

////////////////////////////////////////////////////////

extension Router: HorizontalTestViewControllerDelegate {

    func toVerticalButtonPressed(inHorizontalVC sender: HorizontalTestViewController) {
        navigationController.popToViewController(_verticalTestVC, animated: true)
    }
}

////////////////////////////////////////////////////////

extension Router: VerticalTestViewControllerDelegate {

    func toHorizontalButtonPressed(inVerticalVC sender: VerticalTestViewController) {
        navigationController.pushViewController(_horizontalTestVC, animated: true)
    }
}

