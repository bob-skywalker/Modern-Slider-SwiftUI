# ModernSlider

A beautifully designed, customizable SwiftUI slider component with haptic feedback, smooth animations, and full iOS 17+ support.

![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)
![SwiftPM](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)

## Features

- 🎨 **Fully Customizable** - Control colors, dimensions, icons, and more
- 📱 **Modern Design** - Sleek appearance that adapts to light and dark mode
- 🔊 **Haptic Feedback** - Built-in sensory feedback for better user experience
- ⚡ **Smooth Animations** - Spring-based animations with natural feel
- 🎯 **Precise Control** - Optional increment/decrement buttons
- 🔗 **SwiftUI Native** - Built entirely with SwiftUI for seamless integration
- ♿ **Accessible** - Supports localized strings and system accessibility features

## Installation

### Swift Package Manager

Add ModernSlider to your project using Xcode:

1. In Xcode, select **File > Add Package Dependencies...**
2. Enter the repository URL: `https://github.com/yourusername/ModernSlider.git`
3. Select the version you want to use
4. Click **Add Package**

Or add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/ModernSlider.git", from: "1.0.0")
]
```

## Quick Start

Import ModernSlider and add it to your view:

```swift
import SwiftUI
import ModernSlider

struct ContentView: View {
    @State private var value: Int = 15

    var body: some View {
        ModernSlider(
            buttonImage: "figure.walk",
            value: $value,
            in: 0...30
        )
    }
}
```

## Usage Examples

### Basic Slider

```swift
@State private var volume: Int = 50

ModernSlider(
    buttonImage: "speaker.wave.2",
    value: $volume,
    in: 0...100
)
```

### Slider with Title

```swift
@State private var questions: Int = 10

ModernSlider(
    title: "Number of Questions",
    buttonImage: "questionmark.circle",
    value: $questions,
    in: 5...50
)
```

### Slider with Side Buttons

```swift
@State private var speed: Int = 5

ModernSlider(
    title: "Speed",
    buttonImage: "gauge",
    value: $speed,
    in: 1...10,
    leftSideImage: "tortoise",
    rightSideImage: "hare"
)
```

### Custom Colors and Dimensions

```swift
@State private var brightness: Int = 75

ModernSlider(
    title: "Brightness",
    buttonImage: "sun.max",
    sliderWidth: 300,
    sliderHeight: 60,
    sliderColor: .yellow,
    value: $brightness,
    in: 0...100
)
```

### With Change Callbacks

```swift
@State private var temperature: Int = 72

ModernSlider(
    title: "Temperature: \(temperature)°F",
    buttonImage: "thermometer",
    value: $temperature,
    in: 60...80,
    onChange: { newValue in
        print("Temperature changing: \(newValue)")
    },
    onChangeEnded: { finalValue in
        print("Final temperature: \(finalValue)")
        // Save to UserDefaults, update settings, etc.
    }
)
```

### Custom Haptic Feedback

```swift
@State private var intensity: Int = 5

ModernSlider(
    buttonImage: "waveform",
    value: $intensity,
    in: 1...10,
    sensoryFeedback: .heavy,
    sensoryFeedbackIntensity: 0.8
)
```

## API Reference

### ModernSlider

The main slider component.

#### Initializer Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `LocalizedStringKey?` | `nil` | Optional label displayed above the slider |
| `buttonImage` | `String` | *required* | SF Symbol name for the thumb icon |
| `sliderWidth` | `CGFloat` | `260` | Width of the slider track |
| `sliderHeight` | `CGFloat` | `50` | Height of the slider track and thumb |
| `sliderColor` | `Color` | `.white` | Color of the slider thumb |
| `value` | `Binding<Int>` | *required* | Binding to the current slider value |
| `range` | `ClosedRange<Int>` | `5...30` | Minimum and maximum values |
| `leftSideImage` | `String?` | `nil` | Optional SF Symbol for decrement button |
| `rightSideImage` | `String?` | `nil` | Optional SF Symbol for increment button |
| `sensoryFeedback` | `SensoryFeedback.Weight` | `.medium` | Haptic feedback weight |
| `sensoryFeedbackIntensity` | `Double` | `0.5` | Haptic feedback intensity (0.0-1.0) |
| `onChange` | `((Int) -> Void)?` | `nil` | Callback fired during value changes |
| `onChangeEnded` | `((Int) -> Void)?` | `nil` | Callback fired when dragging ends |

### Available SF Symbols

ModernSlider works with any SF Symbol. Popular choices include:

- **Volume**: `speaker`, `speaker.wave.1`, `speaker.wave.2`, `speaker.wave.3`
- **Brightness**: `sun.min`, `sun.max`, `light.max`, `light.min`
- **Speed**: `speedometer`, `gauge`, `figure.walk`, `figure.run`
- **Time**: `clock`, `timer`, `hourglass`
- **Numbers**: `number`, `textformat.123`, `list.number`
- **Music**: `music.note`, `waveform`, `metronome`

Find more at [SF Symbols Browser](https://developer.apple.com/sf-symbols/).

## Customization Tips

### Dark Mode Support

ModernSlider automatically adapts to the current color scheme. The track, thumb, and shadows adjust for optimal visibility in both light and dark modes.

### Dynamic Type

The title text supports Dynamic Type and will scale with the user's text size preferences.

### Localization

Use `LocalizedStringKey` for the title parameter to support multiple languages:

```swift
ModernSlider(
    title: "slider_speed_title", // Key from Localizable.strings
    buttonImage: "speedometer",
    value: $speed
)
```

## Requirements

- iOS 17.0+
- Swift 6.2+
- Xcode 16.0+

## License

ModernSlider is available under the MIT license. See the LICENSE file for more info.

## Author

Created by Bo Zhong

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

If you find ModernSlider useful, please consider starring the repository!
