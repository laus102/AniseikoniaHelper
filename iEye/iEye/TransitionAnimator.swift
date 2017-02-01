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
   
   func startingCenter(of frame: CGRect) -> CGPoint {
      switch self {
         case .horizontal: return CGPoint(x: 0.0, y: frame.midY)
         case .vertical: return CGPoint(x: frame.midX, y: frame.maxY)
         case .done: return CGPoint(x: frame.midX, y: frame.midY)
      }
   }
   
   func endingCenter(of view: UIView) -> CGPoint
      { return CGPoint(x: view.bounds.midX, y: view.bounds.midY) }
   
   func startingTransform() -> CGAffineTransform {
      switch self {
         case .done: return CGAffineTransform(scaleX: 0.0, y: 0.0)
        default: return CGAffineTransform.identity
      }
   }
   
}



class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
   let duration = 0.5
   var transition = TransitionType.done  // default transition
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { return duration }
   
   ///////////////////////////////////////////////////////////////////////////////////////////////
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
      let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)! // where we goin
      toView.clipsToBounds = true
      toView.center = transition.startingCenter(of: toView.frame)
      toView.transform = transition.startingTransform()
      
      transitionContext.containerView.addSubview(toView)
      transitionContext.containerView.bringSubview(toFront: toView)
      
      UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.9,
                     initialSpringVelocity: 0.0, options: [],
                     animations: { toView.transform = CGAffineTransform.identity
                                   toView.center = self.transition.endingCenter(of: toView) },
                     completion: { _ in transitionContext.completeTransition(true) } )
      
      //      toView.center = ( (transitionType == .horizontal) || (transitionType == .vertical) ) ?
      //                        ( transitionType == .horizontal ?
      //                           CGPoint(x: 0.0, y: toView.frame.midY)
      //                           : CGPoint(x: toView.frame.midX, y: toView.frame.maxY) )
      //                        : CGPoint(x: toView.frame.midX, y: toView.frame.midY)
      
   }
   
//      let round = CABasicAnimation(keyPath: "cornerRadius")
//      round.fromValue = 20.0/xScaleFactor
//      round.toValue = 0.0
//      round.duration = duration / 2
//      toView.layer.add(round, forKey: nil)
//      toView.layer.cornerRadius = 0.0
   
}

