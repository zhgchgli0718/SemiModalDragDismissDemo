//
//  ViewController.swift
//  InteractiveDismissDemo
//
//  Created by your3i on 2018/09/30.
//  Copyright © 2018 your3i. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func handleOpenTapped(_ sender: Any) {
        let viewController = DetailsViewController.viewController()
        present(viewController, animated: true, completion: nil)
    }
}

