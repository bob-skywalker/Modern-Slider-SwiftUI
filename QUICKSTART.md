# ModernSlider - Quick Start Guide

Get started with ModernSlider in under 5 minutes!

## Installation

Add ModernSlider to your project via Swift Package Manager:

1. In Xcode: **File > Add Package Dependencies...**
2. Paste: `https://github.com/yourusername/ModernSlider.git`
3. Click **Add Package**

## Basic Usage

### Step 1: Import the Module

```swift
import ModernSlider
```

### Step 2: Create a State Variable

```swift
@State private var sliderValue: Int = 15
```

### Step 3: Add ModernSlider to Your View

```swift
ModernSlider(
    buttonImage: "star.fill",
    value: $sliderValue,
    in: 0...30
)
```

## Complete Example

Here's a complete working example you can copy and paste:

```swift
import SwiftUI
import ModernSlider

struct ContentView: View {
    @State private var rating: Int = 5

    var body: some View {
        VStack(spacing: 30) {
            Text("Rate Your Experience")
                .font(.title)

            Text("Rating: \(rating)/10")
                .font(.headline)

            ModernSlider(
                title: "Your Rating",
                buttonImage: "star.fill",
                value: $rating,
                in: 1...10,
                leftSideImage: "hand.thumbsdown",
                rightSideImage: "hand.thumbsup"
            )
        }
        .padding()
    }
}
```

## Common Patterns

### Volume Control

```swift
@State private var volume: Int = 50

ModernSlider(
    title: "Volume",
    buttonImage: "speaker.wave.2",
    value: $volume,
    in: 0...100,
    leftSideImage: "speaker",
    rightSideImage: "speaker.wave.3"
)
```

### Difficulty Selector

```swift
@State private var difficulty: Int = 2

let difficultyText = ["Easy", "Medium", "Hard"][difficulty]

VStack {
    Text("Difficulty: \(difficultyText)")

    ModernSlider(
        buttonImage: "flame",
        value: $difficulty,
        in: 0...2
    )
}
```

### Timer Duration

```swift
@State private var minutes: Int = 5

ModernSlider(
    title: "Timer: \(minutes) min",
    buttonImage: "timer",
    sliderColor: .orange,
    value: $minutes,
    in: 1...60
)
```

## Next Steps

- Check out the full [README.md](README.md) for all available options
- Explore the API documentation for advanced customization
- See the preview in `ModernSlider.swift` for more examples

## Tips

1. **SF Symbols**: Use any SF Symbol name for `buttonImage`
2. **Side Buttons**: Add `leftSideImage` and `rightSideImage` for quick +/- controls
3. **Callbacks**: Use `onChange` for real-time updates and `onChangeEnded` to save final values
4. **Customize**: Adjust `sliderWidth`, `sliderHeight`, and `sliderColor` to match your design

## Troubleshooting

### Slider not responding
- Ensure your `value` binding uses `$` prefix
- Check that your range contains the initial value

### Build errors
- Verify you're targeting iOS 17.0 or later
- Make sure SwiftUI is imported

### Need Help?

Open an issue on GitHub with your question or problem!
