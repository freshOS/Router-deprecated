//
//  Navigation.swift
//  RouterExample
//
//  Created by Max Konovalov on 28/02/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Router

enum ExampleNavigation: Navigation {
    case red
    case green(Int)
    case blue
}

struct ExampleAppNavigation: AppNavigation {
   
    func viewController(for navigation: Navigation) -> UIViewController {
        guard let navigation = navigation as? ExampleNavigation else {
            fatalError("Expected navigation of type \(ExampleNavigation.self)")
        }
        switch navigation {
        case .red:
            return RedViewController()
        case .green(let n):
            return GreenViewController(number: n)
        case .blue:
            return BlueViewController()
        }
    }
    
    func navigate(using navigation: Navigation, from sourceViewController: UIViewController, to destinationViewController: UIViewController) {
        guard let navigation = navigation as? ExampleNavigation else {
            fatalError("Expected navigation of type \(ExampleNavigation.self)")
        }
        switch navigation {
        case .red:
            let navigationController = UINavigationController(rootViewController: destinationViewController)
            sourceViewController.present(navigationController, animated: true, completion: nil)
        case .green:
            sourceViewController.navigationController?.pushViewController(destinationViewController, animated: true)
        case .blue:
            destinationViewController.modalTransitionStyle = .flipHorizontal
            sourceViewController.present(destinationViewController, animated: true, completion: nil)
        }
    }
    
}
