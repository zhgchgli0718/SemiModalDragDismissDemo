//
//  CustomPresentationController.swift
//  InteractiveDismissDemo
//
//  Created by your3i on 2018/09/30.
//  Copyright © 2018 your3i. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {

    private var dimmingView: UIView!

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }

    private func setupDimmingView() {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimmingView = view

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        dimmingView.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }

        let rect = CGRect(x: 0, y: containerView.bounds.height / 2.0, width: containerView.bounds.width, height: containerView.bounds.height / 2.0)
        return rect
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }

        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0
        containerView.addSubview(dimmingView)

        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(
                alongsideTransition: { [weak self] _ in
                    self?.dimmingView.alpha = 1.0
                }, completion: nil)
        } else {
            dimmingView.alpha = 1.0
        }
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(
                alongsideTransition: { [weak self] _ in
                    self?.dimmingView.alpha = 0.0
                }, completion: nil)
        } else {
            dimmingView.alpha = 0.0
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
}
