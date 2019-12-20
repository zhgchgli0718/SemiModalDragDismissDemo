//
//  DetailsViewController.swift
//  InteractiveDismissDemo
//
//  Created by your3i on 2018/09/30.
//  Copyright © 2018 your3i. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {

    private var interactor: CustomDismissInteractor!

    static func viewController() -> DetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = viewController
        return viewController
    }

    override func loadView() {
        super.loadView()
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = CustomDismissInteractor.instance(self, panOnView: view)
        interactor.wantsInteractiveStart = false
    }

    @IBAction func handleCloseTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomDismissAnimator()
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor
    }
}
