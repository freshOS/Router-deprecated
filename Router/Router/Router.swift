//
//  Router.swift
//  Router
//
//  Created by Sacha Durand Saint Omer on 27/02/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

public class Router {
    static let `default`:IsRouter = DefaultRouter()
}

public protocol Navigation { }

public protocol AppNavigation {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController)
}

public protocol IsRouter {
    func setupAppNavigation(appNavigation: AppNavigation)
    func navigate(_ navigation: Navigation, from: UIViewController)
    func didNavigate(block: @escaping (Navigation) -> Void)
}

extension UIViewController {
    func navigate(_ navigation: Navigation) {
        Router.default.navigate(navigation, from: self)
    }
}

public class DefaultRouter: IsRouter {
    
    var appNavigation: AppNavigation?
    var didNavigateBlocks = [((Navigation) -> Void)] ()
    
    public func setupAppNavigation(appNavigation: AppNavigation) {
        self.appNavigation = appNavigation
    }
    
    public func navigate(_ navigation: Navigation, from: UIViewController) {
        if let toVC = appNavigation?.viewcontrollerForNavigation(navigation: navigation) {
            appNavigation?.navigate(navigation, from: from, to: toVC)
            for b in didNavigateBlocks {
                b(navigation)
            }
        }
    }
    
    public func didNavigate(block: @escaping (Navigation) -> Void) {
        didNavigateBlocks.append(block)
    }
}
