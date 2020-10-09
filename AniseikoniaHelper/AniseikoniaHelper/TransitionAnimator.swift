//
//  TransitionAnimator.swift
//  AniseikoniaHelper
//
//  Created by Brendan Lau on 1/26/17.
//  Copyright © 2017 Brendan Lau. All rights reserved.
//

import UIKit


enum TransitionType: String {
   case horizontal = "Horizontal" // Left to Right
   case vertical = "Vertical" // Bottom to Top
   case doneVertical = "DoneVertical" // Top to Bottom
   case doneHorizontal = "DoneHorizontal" // Right to Left
   
   func startingCenter(of frame: CGRect) -> CGPoint {
      switch self {
         case .horizontal: return CGPoint(x: 0.0, y: frame.midY)
         case .vertical: return CGPoint(x: frame.midX, y: frame.maxY)
         case .doneVertical: return CGPoint(x: frame.midX, y: frame.minY)
         case .doneHorizontal: return CGPoint(x: frame.maxX, y: frame.midY)
      }
   }
   
   func endingCenter(of view: UIView) -> CGPoint
      { return CGPoint(x: view.bounds.midX, y: view.bounds.midY) }
   
   func startingTransform() -> CGAffineTransform {
//      { return (self == .doneVertical) || (self == .doneHorizontal) ? CGAffineTransform(scaleX: 0.0, y: 0.0) : CGAffineTransform.identity }
      return CGAffineTransform.identity
   }
}


class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
   let duration = 0.5
   var transition = TransitionType.horizontal  // default transition
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { return duration }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
      let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)! // where we goin
      toView.clipsToBounds = true
      toView.center = transition.startingCenter(of: toView.frame)
      toView.transform = transition.startingTransform()
      
      transitionContext.containerView.addSubview(toView)
      transitionContext.containerView.bringSubviewToFront(toView)
      
      UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.9,
                     initialSpringVelocity: 0.0, options: [],
                     animations: { toView.transform = CGAffineTransform.identity
                                   toView.center = self.transition.endingCenter(of: toView) },
                     completion: { _ in transitionContext.completeTransition(true) } )
      
      let round = CABasicAnimation(keyPath: "cornerRadius")
      round.fromValue = 5.0
      round.toValue = 0.0
      round.duration = duration / 2
      toView.layer.add(round, forKey: nil)
      toView.layer.cornerRadius = 0.0
      
   }
}

