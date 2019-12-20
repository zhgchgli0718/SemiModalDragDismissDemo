//
//  CustomDismissAnimator.swift
//  InteractiveDismissDemo
//
//  Created by your3i on 2018/09/30.
//  Copyright © 2018 your3i. All rights reserved.
//

import UIKit

final class CustomDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(true)
            return
        }

        let fromView = transitionContext.view(forKey: .from)!
        var fromFinalFrame = transitionContext.finalFrame(for: fromViewController)
        let newFinalOrigin = CGPoint(x: fromFinalFrame.origin.x, y: fromFinalFrame.origin.y + fromFinalFrame.size.height)
        fromFinalFrame.origin = newFinalOrigin

        let duration = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                fromView.frame = fromFinalFrame
            },
            completion: { _ in
                let success = !transitionContext.transitionWasCancelled
                transitionContext.completeTransition(success)
            }
        )
    }

}


