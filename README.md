# Router
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
