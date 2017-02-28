//
//  Router.swift
//  Router
//
//  Created by Sacha Durand Saint Omer on 27/02/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

public class Router {
    public static let `default`: NavigationRouter = DefaultRouter()
}

public protocol Navigation { }

public protocol AppNavigation {
    func viewController(for navigation: Navigation) -> UIViewController
    func navigate(using navigation: Navigation, from sourceViewController: UIViewController, to destinationViewController: UIViewController)
}

public protocol NavigationRouter {
    func setupAppNavigation(_ appNavigation: AppNavigation)
    func navigate(using navigation: Navigation, from sourceViewController: UIViewController)
    func didNavigate(_ block: @escaping (Navigation) -> Void)
    var appNavigation: AppNavigation? { get }
}

public extension UIViewController {
    public func navigate(using navigation: Navigation) {
        Router.default.navigate(using: navigation, from: self)
    }
}

public class DefaultRouter: NavigationRouter {
    
    public var appNavigation: AppNavigation?
    var didNavigateBlocks = [((Navigation) -> Void)]()
    
    public func setupAppNavigation(_ appNavigation: AppNavigation) {
        self.appNavigation = appNavigation
    }
    
    public func navigate(using navigation: Navigation, from sourceViewController: UIViewController) {
        if let destinationViewController = appNavigation?.viewController(for: navigation) {
            appNavigation?.navigate(using: navigation, from: sourceViewController, to: destinationViewController)
            for b in didNavigateBlocks {
                b(navigation)
            }
        }
    }
    
    public func didNavigate(_ block: @escaping (Navigation) -> Void) {
        didNavigateBlocks.append(block)
    }
}

// Injection helper
public protocol Initializable { init() }
open class RuntimeInjectable: NSObject, Initializable {
    public required override init() {}
}

public func appNavigationFromString(_ appNavigationClassString: String) -> AppNavigation {
    let appNavClass = NSClassFromString(appNavigationClassString) as! RuntimeInjectable.Type
    let appNav = appNavClass.init()
    return appNav as! AppNavigation
}

