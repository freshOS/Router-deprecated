//
//  ViewController.swift
//  RouterExample
//
//  Created by Max Konovalov on 28/02/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func presentRed(_ sender: UIButton) {
        navigate(using: .red)
    }

    @IBAction func presentGreen(_ sender: UIButton) {
        navigate(using: .green(42))
    }
    
    @IBAction func presentBlue(_ sender: UIButton) {
        navigate(using: .blue)
    }
    
}

