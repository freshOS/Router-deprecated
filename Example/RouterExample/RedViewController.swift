//
//  RedViewController.swift
//  RouterExample
//
//  Created by Max Konovalov on 28/02/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

class RedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Red"
        view.backgroundColor = .red
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
    
    @objc func done() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
