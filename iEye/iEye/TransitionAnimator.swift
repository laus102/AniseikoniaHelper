//
//  TransitionAnimator.swift
//  iEye
//
//  Created by Brendan Lau on 1/19/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

enum TransitionType: String {
   case horizontal = "Horizontal"
   case vertical = "Vertical"
   case done = "Done"
}

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
   let duration = 3.0
   var transitionType =  TransitionType.done
   var presenting = true
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { return duration }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
      switch transitionType {
         case TransitionType.horizontal: animateHorizontalTransition(using: transitionContext)
         case TransitionType.vertical: animateVerticalTransition(using: transitionContext)
         case TransitionType.done: animateDoneTransition(using: transitionContext)
      }
   }
   
   ///////////////////////////////////////////////////////////////////////////////////////////////
   
   func animateHorizontalTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
      let containerView = transitionContext.containerView
      let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)! // selectTest view
      let selectTestView = presenting ? toView : transitionContext.view(forKey: UITransitionContextViewKey.from)!
      let initialFrame = presenting ? CGRect.zero : selectTestView.frame
      let finalFrame = presenting ?  selectTestView.frame : CGRect.zero
      
      let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
      let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
      
      let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
      
      if presenting {
         selectTestView.transform = scaleTransform
         selectTestView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
         selectTestView.clipsToBounds = true
      }
      
      containerView.addSubview(toView)
      containerView.bringSubview(toFront: selectTestView)
      
      UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.73,
                     initialSpringVelocity: 0.0, options: [],
                     animations: {
                        selectTestView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                        selectTestView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
      },
                     completion: {_ in
                        transitionContext.completeTransition(true)
      }
      )
      
      let round = CABasicAnimation(keyPath: "cornerRadius")
      round.fromValue = presenting ? 20.0/xScaleFactor : 0.0
      round.toValue = presenting ? 0.0 : 20.0/xScaleFactor
      round.duration = duration / 2
      selectTestView.layer.add(round, forKey: nil)
      selectTestView.layer.cornerRadius = presenting ? 0.0 : 20.0/xScaleFactor
      
   }
   
   ///////////////////////////////////////////////////////////////////////////////////////////////
   
   func animateVerticalTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
      let containerView = transitionContext.containerView
      let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)! // selectTest view
      let selectTestView = presenting ? toView : transitionContext.view(forKey: UITransitionContextViewKey.from)!
      let initialFrame = presenting ? CGRect.zero : selectTestView.frame
      let finalFrame = presenting ?  selectTestView.frame : CGRect.zero
      
      let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
      let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
      
      let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
      
      if presenting {
         selectTestView.transform = scaleTransform
         selectTestView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
         selectTestView.clipsToBounds = true
      }
      
      containerView.addSubview(toView)
      containerView.bringSubview(toFront: selectTestView)
      
      UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.73,
                     initialSpringVelocity: 0.0, options: [],
                     animations: {
                        selectTestView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                        selectTestView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
      },
                     completion: {_ in
                        transitionContext.completeTransition(true)
      }
      )
      
      let round = CABasicAnimation(keyPath: "cornerRadius")
      round.fromValue = presenting ? 20.0/xScaleFactor : 0.0
      round.toValue = presenting ? 0.0 : 20.0/xScaleFactor
      round.duration = duration / 2
      selectTestView.layer.add(round, forKey: nil)
      selectTestView.layer.cornerRadius = presenting ? 0.0 : 20.0/xScaleFactor
   }
   
   ///////////////////////////////////////////////////////////////////////////////////////////////
   
   func animateDoneTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
      let containerView = transitionContext.containerView
      let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)! // selectTest view
      let selectTestView = presenting ? toView : transitionContext.view(forKey: UITransitionContextViewKey.from)!
      let initialFrame = presenting ? CGRect.zero : selectTestView.frame
      let finalFrame = presenting ?  selectTestView.frame : CGRect.zero
      
      let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
      let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
      
      let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
      
      if presenting {
         selectTestView.transform = scaleTransform
         selectTestView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
         selectTestView.clipsToBounds = true
      }
      
      containerView.addSubview(toView)
      containerView.bringSubview(toFront: selectTestView)
      
      UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.73,
                     initialSpringVelocity: 0.0, options: [],
                     animations: {
                        selectTestView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                        selectTestView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
      },
                     completion: {_ in
                        transitionContext.completeTransition(true)
      }
      )
      
      let round = CABasicAnimation(keyPath: "cornerRadius")
      round.fromValue = presenting ? 20.0/xScaleFactor : 0.0
      round.toValue = presenting ? 0.0 : 20.0/xScaleFactor
      round.duration = duration / 2
      selectTestView.layer.add(round, forKey: nil)
      selectTestView.layer.cornerRadius = presenting ? 0.0 : 20.0/xScaleFactor
   }
   
}

