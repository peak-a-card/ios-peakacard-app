import SwiftUI

enum MainTheme: StylesheetTheme {

    static func margin(_ margin: Margin) -> CGFloat {
        switch margin {
        case .small: return 4
        case .medium: return 8
        case .large: return 16
        case .extraLarge: return 24
        case .extraExtraLarge: return 32
        }
    }

    static func color(_ color: ColorSet) -> UIColor {
        switch color {
        case .primary: return .primary
        case .primaryDark: return .primaryDark
        case .accent: return .accent
        case .background: return .background
        case .onPrimary: return .onPrimary
        }
    }

    static func color(_ color: ColorSet) -> Color {
        switch color {
        case .primary: return .primary
        case .primaryDark: return .primaryDark
        case .accent: return .accent
        case .background: return .background
        case .onPrimary: return .onPrimary
        }
    }

    static func font(_ scale: FontScale) -> Font {
        switch scale {
        case .h3: return .largeTitle
        }
    }
}
