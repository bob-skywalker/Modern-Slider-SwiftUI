//
//  Theme.swift
//  ModernSlider
//
//  Created by Bo Zhong on 2/6/26.
//

import Foundation
import SwiftUI

/// A collection of color constants used throughout the ModernSlider component.
///
/// These colors are designed to provide optimal appearance in both light and dark modes.
struct Colors {
    static let lightTracksStroke = Color.gray.opacity(1)
    static let darkTrackFill = Color(white: 0.3).opacity(0.5)
    static let lightTrackFill = Color(white: 0.8).opacity(0.5)
    static let lightThumbFill = Color(red: 240/255, green: 240/255, blue: 240/255)
    static let darkThumbFill = Color(red: 225/255, green: 225/255, blue: 225/255)
    static let thumbShadowLight = Color.black.opacity(0.25)
    static let thumbShadowDark = Color.white.opacity(0.05)
    static let thumbIconColor = Color(red: 25/255, green: 25/255, blue: 25/255)
}

/// Extension providing color scheme-specific colors for the slider components.
///
/// These computed properties automatically return the appropriate color based on
/// whether the interface is in light or dark mode.
extension ColorScheme {
    /// The fill color for the slider track background.
    var trackFill: Color {
        self == .dark ? Colors.darkTrackFill : Colors.lightTrackFill
    }

    /// The stroke color for the slider track border.
    var trackStroke: Color {
        self == .light ? Colors.lightTracksStroke : .clear
    }

    /// The fill color for the slider thumb.
    var thumbFill: Color {
        self == .dark ? Colors.darkThumbFill : Colors.lightThumbFill
    }

    /// The shadow color for the slider thumb.
    var thumbShadow: Color {
        self == .dark ? Colors.thumbShadowDark : Colors.thumbShadowLight
    }
}
