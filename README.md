# Router

[![Language: Swift 3](https://img.shields.io/badge/language-swift 3-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 8+](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://www.bitrise.io/app/11b4cd282c1d70b3.svg?token=TFKzkSx6pehcZOj5ouWrFg)](https://www.bitrise.io/app/11b4cd282c1d70b3)
<!-- [![codebeat badge](https://codebeat.co/badges/768d3017-1e65-47e0-b287-afcb8954a1da)](https://codebeat.co/projects/github-com-s4cha-then) -->
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/freshOS/then/blob/master/LICENSE)
[![Release version](https://img.shields.io/badge/release-0.0.5-blue.svg)]()

Decouples routing between ViewControllers


```swift
// From
navigationController?.pushViewController(AboutViewController(), animated: true)
// to
navigate(.about)
```

- [x] Decouples Viewcontrollers  
- [x] Testable navigation  
- [x] Faster compile times

A cool side effect of extracting navigation logic on big projects is improving compilation times.
Indeed Strong dependencies due to navigation code often makes Xcode recompile files you never modified. Router enables you to extract your routing logic in a separate file.


## Get started

### 1 - Declare your Navigation enum
```swift
enum MyNavigation: Navigation {
    case about
}
```

### 2 - Declare your App Navigation

```swift
struct MyAppNavigation: AppNavigation {

    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        if let navigation = navigation as? MyNavigation {
            switch navigation {
            case .about:
                return AboutViewController()
            }
        }
        return UIViewController()
    }

    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        if let myNavigation = navigation as? MyNavigation {
            switch myNavigation {
            case .about:
                from.navigationController?.pushViewController(to, animated: true)
            }
        }
    }
}
```

### 3 - Register your navigation on App Launch

In `AppDelegate.swift`, before everything :
```swift
Router.default.setupAppNavigation(appNavigation: MyAppNavigation())
```

### 4 - Replace navigations in your View Controllers

You can now call nagivations from you view controllers :

```swift
navigate(MyNavigation.about)
```

Bridge `Navigation` with your own enum type, here `MyNavigation` so that we don't have to type our own.
```swift
extension UIViewController {

    func navigate(_ navigation: MyNavigation) {
        navigate(navigation as Navigation)
    }
}
```
You can now write :
```swift
navigate(.about)
```


### Bonus - Tracking
Another cool thing about decoupling navigation is that you can now extract traking code from view Controllers as well. You can be notified by the router whenever a navigation happened.

```swift
Router.default.didNavigate { navigation in
    // Plug Analytics for instance
    GoogleAnalitcs.trackPage(navigation)
}

```

## Installation

#### Carthage
```
github "freshOS/Router"
```
#### Manually
Simply Copy and Paste `Router.swift` files in your Xcode Project :)

#### As A Framework
Grab this repository and build the Framework target on the example project. Then Link against this framework.
