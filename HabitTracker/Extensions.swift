//
//  Extensions.swift
//  HabitTracker
//
//  Created by SCOTT CROWDER on 11/8/23.
//

import SwiftUI

// Hex Color Code Support
extension ShapeStyle where Self == Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
    
    static var hexDarkBackground: Color {
        Self(hex: "#1A1A33")
    }
    
    static var hexLightBackground: Color {
        Self(hex: "#333344")
    }
}

extension String {
    // Removes the need for a double negative such as !password.trimmingCharacters(in: .whitespaces).isEmpty
    var isNotEmpty: Bool {
        trimmingCharacters(in: .whitespaces).isEmpty == false
    }
}
