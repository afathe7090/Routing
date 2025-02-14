<p align="center">
  <img src = "https://github.com/JamesSedlacek/Routing/blob/main/Assets/RoutingBannerArt.png">
</p>

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![GitHub stars](https://img.shields.io/github/stars/JamesSedlacek/Routing.svg)](https://github.com/JamesSedlacek/Routing/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/JamesSedlacek/Routing.svg?color=blue)](https://github.com/JamesSedlacek/Routing/network)
[![GitHub contributors](https://img.shields.io/github/contributors/JamesSedlacek/Routing.svg?color=blue)](https://github.com/JamesSedlacek/Routing/network)
<a href="https://github.com/JamesSedlacek/Routing/pulls"><img src="https://img.shields.io/github/issues-pr/JamesSedlacek/Routing" alt="Pull Requests Badge"/></a>
<a href="https://github.com/JamesSedlacek/Routing/issues"><img src="https://img.shields.io/github/issues/JamesSedlacek/Routing" alt="Issues Badge"/></a>

## Description

`Routing` is a framework for abstracting navigation logic from views in SwiftUI.
- Simplifies code by removing navigation responsibilities from views.
- Leads to cleaner, more manageable code.
- Promotes better separation of concerns.
- Ridiculously **lightweight**.
- **Type-safe** routing using enums and associated values.
- Unit Tested protocol implementations.
- Zero 3rd party dependencies.

<br>

## Requirements

- **iOS**: Requires iOS 16.0 or later.
- **macOS**: Requires macOS 13.0 or later.

<br>

## Installation

You can install `Routing` using the Swift Package Manager.

1. In Xcode, select "File" > "Add Package Dependencies".
2. Copy & paste the following into the "Search or Enter Package URL" search bar.
```
https://github.com/JamesSedlacek/Routing.git
```
4. Xcode will fetch the repository & the "Routing" library will be added to your project.

<br>

## Getting Started

1. Create the "Route" enum where views will navigate to.

``` swift
import SwiftUI
import Routing

enum Route: ViewDisplayable {
    case detail
    case settings
    
    @ViewBuilder
    var viewToDisplay: some View {
        switch self {
        case .detail:
            DetailView()
        case .settings:
            SettingsView()
        }
    }
}
```

2. The RoutingView will be used instead of a NavigationStack.
Pass in the Route enumeration, so that the RouterView can use them. 

``` swift
import SwiftUI
import Routing

struct ContentView: View {
    var body: some View {
        RoutingView(Route.self) { router in
            // Main Content goes here
        }
    }
}
```

3. Handle navigation using the Router functions

```swift
// NavigationPath
func pop(_ count: Int)
func popToRoot()
func push(_ destination: Destination)
func push(_ destinations: [Destination])

// Sheet
func presentSheet(_ destination: Destination)
func dismissSheet()

// FullScreenCover
func presentFullScreenCover(_ destination: Destination)
func dismissFullScreenCover()

// Alert
func presentAlert(_ alert: Alert)
func dismissAlert()

// Toast (not implemented yet)
func presentToast(_ toast: Toast)
func dismissToast()
```

<br>

## Router In View Example

```swift
import SwiftUI
import Routing

enum ExampleRoute: ViewDisplayable {
    case detail
    case settings
    
    @ViewBuilder
    var viewToDisplay: some View {
        switch self {
        case .detail:
            DetailView()
        case .settings:
            SettingsView()
        }
    }
}

struct ExampleView: View {
    var body: some View {
        RoutingView(ExampleRoute.self) { router in
    
            // Example of using `push`
            Button("Go to Detail View") {
                router.push(.detail)
            }
    
            // Example of using `pop`
            Button("Go back") {
                router.pop()
            }
        
            // Example of using `popToRoot`
            Button("Go back to Root") {
                router.popToRoot()
            }
            
            // Example of using `presentSheet`
            Button("Present Settings View") {
                router.presentSheet(.settings)
            }
            
            // Example of using `presentFullScreenCover`
            Button("Present Settings View") {
                router.presentFullScreenCover(.settings)
            }

            // Example of using `presentAlert`
            Button("Show alert") {
                router.presentAlert(.init(title: Text("Testing alerts"),
                                          primaryButton: .default(Text("OK")),
                                          secondaryButton: .cancel(Text("Cancel"))))
            }
        }
    }
}
```

## ViewModel Example

``` swift
import SwiftUI
import Routing

enum ExampleRoute: ViewDisplayable {
    case detail
    case settings
    
    @ViewBuilder
    var viewToDisplay: some View {
        switch self {
        case .detail:
            DetailView()
        case .settings:
            SettingsView()
        }
    }
}

class ExampleViewModel: ObservableObject {
    private let router: Router<ExampleRoute>

    init(router: Router<ExampleRoute>) {
        self.router = router
    }

    func goToDetailView() {
        router.push(.detail)
    }

    func goBack() {
        router.pop()
    }

    func goBackToRoot() {
        router.popToRoot()
    }
}

struct ExampleView: View {
    @StateObject var viewModel: ExampleViewModel

    var body: some View {
        VStack {
            Button("Go to Detail View") {
                viewModel.goToDetailView()
            }

            Button("Go back") {
                viewModel.goBack()
            }

            Button("Go back to Root") {
                viewModel.goBackToRoot()
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        RoutingView(ExampleRoute.self) { router in
            ExampleView(viewModel: .init(router: router))
        }
    }
}
```

## Author

James Sedlacek, find me on [X/Twitter](https://twitter.com/jsedlacekjr) or [LinkedIn](https://www.linkedin.com/in/jamessedlacekjr/)

## License

<details>
  <summary><strong>Routing is available under the MIT license.</strong></summary>
  <br>

Copyright (c) 2023 James Sedlacek

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

</details>
