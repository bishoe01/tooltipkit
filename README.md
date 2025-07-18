# TooltipKit

A simple SwiftUI package to add tooltips to your views with a single line of code.

## Installation

### Local Package

1. In Xcode, go to `File` > `Add Packages...`
2. Select `Add Local...` and navigate to the root directory of this package.

### Git Package

1. In Xcode, go to `File` > `Add Packages...`
2. Enter the repository URL: `https://github.com/your-username/TooltipKit.git` (Replace `your-username` with your actual GitHub username if you fork this project).

## Usage

Simply add the `.tooltip("Your tooltip message")` modifier to any SwiftUI `View`.

```swift
import SwiftUI
import TooltipKit

struct ContentView: View {
    var body: some View {
        Text("Tap me for a tooltip!")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .tooltip("This is a simple tooltip message.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
