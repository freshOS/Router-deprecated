//
//  BlueViewController.swift
//  RouterExample
//
//  Created by Max Konovalov on 28/02/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Blue"
        view.backgroundColor = .blue
        
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Done", for: .normal)
        button.sizeToFit()
        button.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(button)
        button.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    
    @objc func done() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
