![Router](https://raw.githubusercontent.com/freshOS/Router/master/banner.png)

# Router
[![Language: Swift 3](https://img.shields.io/badge/language-swift 3-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 8+](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://www.bitrise.io/app/11b4cd282c1d70b3.svg?token=TFKzkSx6pehcZOj5ouWrFg)](https://www.bitrise.io/app/11b4cd282c1d70b3)
<!-- [![codebeat badge](https://codebeat.co/badges/768d3017-1e65-47e0-b287-afcb8954a1da)](https://codebeat.co/projects/github-com-s4cha-then) -->[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/freshOS/then/blob/master/LICENSE)
[![Release version](https://img.shields.io/badge/release-0.0.6-blue.svg)]()


![Router](https://raw.githubusercontent.com/freshOS/Router/master/Infographics.png)

## Why
Because **classic App Navigation** introduces **tight coupling** between ViewControllers.
Complex Apps navigation can look like a **gigantic spider web**.

Besides the fact that **Navigation responsibility is split** among ViewControllers, modifying a ViewController can cascade recompiles and produce **slow compile times.**

## How
By using a Navigation `enum` to navigate we decouple ViewControllers between them. Aka they don't know each other anymore. So modifying `VCA` won't trigger `VCB` to recompile anymore \o/

```swift
// navigationController?.pushViewController(AboutViewController(), animated: true)
navigate(.about)
```

Navigation code is now encapsulated in a `AppNavigation` object.

## Benefits
- [x] Decouples ViewControllers  
- [x] Makes navigation Testable   
- [x] Faster compile times

## Get started

### 1 - Declare your Navigation enum
```swift
enum MyNavigation: Navigation {
    case about
    case profile(Person)
}
```
Swift enum can take params!
Awesome for us because that's how we will pass data between ViewControllers :)

### 2 - Declare your App Navigation

```swift
struct MyAppNavigation: AppNavigation {

    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        if let navigation = navigation as? MyNavigation {
            switch navigation {
            case .about:
                return AboutViewController()
              case .profile(let p):
                return ProfileViewController(person: p)
            }
        }
        return UIViewController()
    }

    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
      from.navigationController?.pushViewController(to, animated: true)
    }
}

A cool thing is that the swift compiler will produce an error if a navigation
case is not handled !
(which would'nt be the case with URL strings for example)
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

## Shave off compilation times

There is a nasty bug in Swift 3 compiler where the compiler rebuilds files even though they haven't changed.
This is documented here : https://forums.developer.apple.com/thread/62737?tstart=0

Due to this bug, the compilation can go like this :

Change `ViewController1` -> `Build`  
-> Compiles `ViewController1`, referenced in `MyAppNavigation` so   
`MyAppNavigation` gets recompiled.  `MyAppNavigation` is referenced in `AppDelegate` which gets recompiled which references ...
`App` -> `ViewController2` -> `ViewController3` -> `ViewControllerX` you get the point.
Before you know it the entire App gets rebuilt :/

A good this is that most of the app coupling usually comes from navigation. which Router decouples.

We can stop this nonsense until this gets fixed in a future release of Xcode.
Router can help us manage this issue by injecting our AppNavigation implementation at runtime.


In your `AppDelegate.swift`

```swift
// Inject  your AppNavigation  at runtime to avoid recompilation of AppDelegate :)
Router.default.setupAppNavigation(appNavigation: appNavigationFromString("YourAppName.MyAppNavigation"))
```

And make sure your `AppNavigation` implementation is now a `class` that is `RuntimeInjectable`
```swift
class MyAppNavigation: RuntimeInjectable, AppNavigation {
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
