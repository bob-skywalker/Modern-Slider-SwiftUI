// The Swift Programming Language
// https://docs.swift.org/swift-book


//
//  ModernSlider.swift
//
//
//  Created by Bo Zhong on 02/06/26.
//

/// A modern, customizable slider component with haptic feedback and smooth animations.
///
/// `ModernSlider` provides a beautifully designed alternative to the standard SwiftUI slider,
/// featuring a draggable thumb with an SF Symbol icon, optional increment/decrement buttons,
/// and built-in sensory feedback.
///
/// ## Usage
///
/// Create a basic slider by providing a binding to an integer value:
///
/// ```swift
/// @State private var volume: Int = 50
///
/// ModernSlider(
///     buttonImage: "speaker.wave.2",
///     value: $volume,
///     in: 0...100
/// )
/// ```
///
/// ## Topics
///
/// ### Creating a Slider
/// - ``init(title:buttonImage:sliderWidth:sliderHeight:sliderColor:value:in:leftSideImage:rightSideImage:sensoryFeedback:sensoryFeedbackIntensity:onChange:onChangeEnded:)``
///
/// ### Customization
/// - Adding a title label
/// - Setting custom dimensions and colors
/// - Configuring haptic feedback
/// - Adding side increment/decrement buttons
///
/// ### Responding to Changes
/// - ``onChange``
/// - ``onChangeEnded``

import SwiftUI

public struct ModernSlider: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var offset: CGFloat = 0
    @State private var isDragging: Bool = false
    
    @Binding var value: Int
    
    private let title: LocalizedStringKey?
    private let buttonImage: String
    private let sliderWidth: CGFloat
    private let sliderHeight: CGFloat
    private let sliderColor: Color
    private let onChange: ((Int) -> Void)?
    private let onChangeEnded: ((Int) -> Void)?
    private let range: ClosedRange<Int>
    private let leftSideImage: String?
    private let rightSideImage: String?
    private let sensoryFeedback: SensoryFeedback.Weight
    private let sensoryFeedbackIntensity: Double
        
    /// Creates a modern slider with customizable appearance and behavior.
    ///
    /// - Parameters:
    ///   - title: An optional localized string to display above the slider. Supports Dynamic Type.
    ///   - buttonImage: The SF Symbol name to display in the slider thumb (e.g., "speaker.wave.2", "star.fill").
    ///   - sliderWidth: The width of the slider track in points. Default is 260.
    ///   - sliderHeight: The height of the slider track and thumb in points. Default is 50.
    ///   - sliderColor: The color of the slider thumb. Default is `.white`.
    ///   - value: A binding to the current integer value of the slider.
    ///   - range: The closed range of valid values for the slider. Default is `5...30`.
    ///   - leftSideImage: Optional SF Symbol name for the decrement button on the left side.
    ///   - rightSideImage: Optional SF Symbol name for the increment button on the right side.
    ///   - sensoryFeedback: The weight of haptic feedback. Default is `.medium`.
    ///   - sensoryFeedbackIntensity: The intensity of haptic feedback, from 0.0 to 1.0. Default is 0.5.
    ///   - onChange: Optional closure called continuously as the slider value changes during dragging.
    ///   - onChangeEnded: Optional closure called once when the user finishes dragging the slider.
    ///
    /// - Note: The slider automatically adapts to light and dark mode, providing appropriate colors and shadows.
    public init(title: LocalizedStringKey? = nil,
         buttonImage: String,
         sliderWidth: CGFloat = 260,
         sliderHeight: CGFloat = 50,
         sliderColor: Color = .white,
         value: Binding<Int>,
         in range: ClosedRange<Int> = 5...30,
         leftSideImage: String? = nil,
         rightSideImage: String? = nil,
         sensoryFeedback: SensoryFeedback.Weight = .medium,
         sensoryFeedbackIntensity: Double = 0.5,
         onChange: ((Int) -> Void)? = nil,
         onChangeEnded: ((Int) -> Void)? = nil
    ) {
        self.title = title
        self.buttonImage = buttonImage
        self.sliderWidth = sliderWidth
        self.sliderHeight = sliderHeight
        self.sliderColor = sliderColor
        self._value = value
        self.range = range
        self.leftSideImage = leftSideImage
        self.rightSideImage = rightSideImage
        self.sensoryFeedback = sensoryFeedback
        self.sensoryFeedbackIntensity = sensoryFeedbackIntensity
        self.onChange = onChange
        self.onChangeEnded = onChangeEnded
    }
    
    private var halfThumbSize: CGFloat {
        sliderHeight / 2
    }
    
    private var sliderFillWidth: CGFloat {
        let fillAmount = min(offset + halfThumbSize, sliderWidth - halfThumbSize)
        return max(halfThumbSize, fillAmount) + halfThumbSize
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.system(size: 25, weight: .regular, design: .rounded))

            }
            HStack {
                if let leftSideImage {
                    Image(systemName: leftSideImage)
                        .font(.system(size: 18))
                        .onTapGesture {
                            if value > range.lowerBound {
                                value -= 1
                                onChange?(value)
                            }
                        }
                        .sensoryFeedback(.impact(weight: .medium, intensity: 0.5), trigger: value)
                }
                
                Spacer()
                
                SliderView(
                    offset: $offset,
                    isDragging: $isDragging,
                    sliderWidth: sliderWidth,
                    sliderHeight: sliderHeight,
                    sliderColor: sliderColor,
                    buttonImage: buttonImage,
                    colorScheme: colorScheme,
                    onChange: updateValue,
                    onChangeEnded: { onChangeEnded?(value)}
                )
                
                Spacer()
                
                if let rightSideImage {
                    Image(systemName: rightSideImage)
                        .font(.system(size: 18))
                        .onTapGesture {
                            if value < range.upperBound {
                                value += 1
                                onChange?(value)
                            }
                        }
                        .sensoryFeedback(.impact(weight: .medium, intensity: 0.5), trigger: value)
                }

            }
        }
        .padding(12)
        .onChange(of: value) { oldValue, newValue in
            updateOffset(to: newValue)
        }
        .onAppear {
            updateOffset(to: value)
        }
    }
    
    private func updateValue() {
        let pct = offset / (sliderWidth - sliderHeight)
        
        let delta = range.upperBound - range.lowerBound
        let raw = Int(round(pct * CGFloat(delta))) + range.lowerBound
        
        let newValue = min(max(raw, range.lowerBound), range.upperBound)
        
        value = newValue
        onChange?(newValue)
    }
    
    private func updateOffset(to newValue: Int) {
        let clamped = min(max(newValue, range.lowerBound), range.upperBound)
        let delta = range.upperBound - range.lowerBound
        let pct = CGFloat(clamped - range.lowerBound) / CGFloat(delta)
        
        offset = pct * (sliderWidth - sliderHeight)
    }
}


/// A helper view for creating SwiftUI previews with state management.
///
/// This wrapper manages a `@State` property internally, allowing you to preview
/// components that require a binding without managing state in the preview itself.
///
/// - Note: This is primarily used for Xcode previews and examples.
public struct StatePreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    let buttonImage: String
    let leftSideImage: String
    let rightSideImage: String
    private let content: (Binding<Value>) -> Content

    /// Creates a preview wrapper with state management.
    ///
    /// - Parameters:
    ///   - buttonImage: The SF Symbol name for the slider thumb.
    ///   - value: The initial value for the state property.
    ///   - leftSideImage: The SF Symbol name for the left side button.
    ///   - rightSideImage: The SF Symbol name for the right side button.
    ///   - content: A closure that receives a binding and returns the content view.
    public init(
         buttonImage: String,
         value: Value,
         leftSideImage: String,
         rightSideImage: String,
         content: @escaping (Binding<Value>) -> Content) {
        self.buttonImage = buttonImage
        self._value = State(initialValue: value)
        self.leftSideImage = leftSideImage
        self.rightSideImage = rightSideImage
        self.content = content
    }
    
    
    public var body: some View {
        content($value)
    }
}

#Preview {
    @Previewable @State var sliderNumber: Int = 50
    let title: LocalizedStringKey = "Questions: \(sliderNumber)"
    let buttonImage = "figure.walk.motion"
    let leftSideImage = "tortoise"
    let rightSideImage = "hare"
    
    
    StatePreviewWrapper(buttonImage: buttonImage, value: $sliderNumber, leftSideImage: leftSideImage, rightSideImage: rightSideImage) { val in
        
        ModernSlider(
            buttonImage: buttonImage,
            value: $sliderNumber, in: 0...100,
            leftSideImage: leftSideImage,
            rightSideImage: rightSideImage
        )
    }
}




private struct SliderView: View {
    @Binding var offset: CGFloat
    @Binding var isDragging: Bool
    private let feedback = UIImpactFeedbackGenerator(style: .light)
    
    
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    let sliderColor: Color
    let buttonImage: String
    let colorScheme: ColorScheme
    let onChange: () -> Void
    let onChangeEnded: () -> Void
    
    
    private var halfThumbSize: CGFloat {
        sliderHeight / 2
    }
    
    private let tapAnimation: Animation? = .smooth(duration: 0.38, extraBounce: 0.0)
    
    private var sliderFillWidth: CGFloat {
        let fillAmount = min(offset + halfThumbSize, sliderWidth - halfThumbSize)
        return max(halfThumbSize, fillAmount) + halfThumbSize
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                isDragging = true
                updateOffset(at: value.location.x)
                onChange()
            }
            .onEnded { _ in
                isDragging = false
                feedback.impactOccurred()
                onChangeEnded()
            }
    }
    private func updateOffset(at location: CGFloat) {
        let adjustedLocation = location - halfThumbSize
        offset = max(0, min(adjustedLocation, sliderWidth - sliderHeight))
    }
    
    private var sliderTrack: some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: [sliderColor.opacity(0.3), sliderColor.opacity(0.6)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: sliderWidth, height: sliderHeight * 0.6)      // <— slightly slimmer
            .overlay(Capsule().stroke(colorScheme.trackStroke, lineWidth: 0.5))
    }
    
    private var sliderFill: some View {
        Capsule()
            .fill(Color.accentColor)
            .frame(width: sliderFillWidth, height: sliderHeight * 0.6)
            .animation(.easeOut(duration: 0.2), value: sliderFillWidth)
    }
    
    private var sliderThumb: some View {
        Circle()
            .frame(width: sliderHeight, height: sliderHeight)
            .foregroundStyle(sliderColor)
            .brightness(isDragging ? -0.1 : 0)
            .shadow(radius: colorScheme == .dark ? 5 : 3)
            .overlay {
                Image(systemName: buttonImage)
                    .font(.system(size: halfThumbSize))
                    .foregroundStyle(Colors.thumbIconColor)
            }
            .offset(x: offset)
    }
    
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            sliderTrack
            sliderFill
            sliderThumb
        }
        .gesture(dragGesture)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: offset)  // <— springy feel
    }
}


private struct ConditionalBackground: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    let isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .background(isActive ? AnyShapeStyle(.regularMaterial) : AnyShapeStyle(Color.clear))
            .clipShape(RoundedRectangle(cornerRadius: isActive ? 12 : 0))
            .shadow(color: colorScheme.thumbShadow, radius: isActive ? 8 : 0)
    }
}

