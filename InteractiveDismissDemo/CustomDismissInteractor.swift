//
//  CustomDismissInteractor.swift
//  InteractiveDismissDemo
//
//  Created by your3i on 2018/09/30.
//  Copyright © 2018 your3i. All rights reserved.
//

import UIKit

final class CustomDismissInteractor: UIPercentDrivenInteractiveTransition {

    private var interactiveView: UIView!

    private var presented: UIViewController!

    static func instance(_ presented: UIViewController, panOnView view: UIView) -> CustomDismissInteractor {
        let interactor = CustomDismissInteractor()
        interactor.interactiveView = view
        interactor.presented = presented
        interactor.setupPanGesture()
        return interactor
    }

    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.maximumNumberOfTouches = 1
        interactiveView.addGestureRecognizer(panGesture)
    }

    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let thredhold: CGFloat = 0.4

        switch sender.state {
        case .began:
            sender.setTranslation(.zero, in: interactiveView)
            wantsInteractiveStart = true
            presented.dismiss(animated: true, completion: nil)
        case .changed:
            let translation = sender.translation(in: interactiveView)
            guard translation.y >= 0 else {
                sender.setTranslation(.zero, in: interactiveView)
                return
            }

            let percentage = abs(translation.y / interactiveView.bounds.height)
            update(percentage)
        case .ended:
            if percentComplete >= thredhold {
                finish()
                interactiveView.removeGestureRecognizer(sender)
            } else {
                wantsInteractiveStart = false
                cancel()
            }
        case .cancelled, .failed:
            wantsInteractiveStart = false
            cancel()
        default:
            wantsInteractiveStart = false
            return
        }
    }
}
