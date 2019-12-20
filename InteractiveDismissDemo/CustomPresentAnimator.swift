//
//  CustomPresentAnimator.swift
//  InteractiveDismissDemo
//
//  Created by zhgchgli on 2019/12/20.
//  Copyright © 2019 your3i. All rights reserved.
//

import UIKit

final class CustomPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(true)
            return
        }
        
        let path = UIBezierPath(roundedRect: toView.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 7, height: 7))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        toView.layer.mask = mask
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)

        toView.frame.origin.y = UIScreen.main.bounds.size.height
        toView.frame.size.height = UIScreen.main.bounds.size.height - 40
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                toView.frame.origin.y = 40
            },
            completion: { _ in
                let success = !transitionContext.transitionWasCancelled
                transitionContext.completeTransition(success)
            }
        )
    }

}
