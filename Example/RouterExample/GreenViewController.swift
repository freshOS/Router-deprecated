//
//  GreenViewController.swift
//  RouterExample
//
//  Created by Max Konovalov on 28/02/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController {

    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 64)
        return label
    }()
    
    convenience init(number: Int) {
        self.init(nibName: nil, bundle: nil)
        label.text = "\(number)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Green"
        view.backgroundColor = .green
        
        view.addSubview(label)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    }
    
}
