import SwiftUI

protocol StylesheetTheme {
    static func margin(_ margin: Margin) -> CGFloat
    static func color(_ color: ColorSet) -> UIColor
    static func color(_ color: ColorSet) -> Color
    static func font(_ scale: FontScale) -> Font
}

enum Margin {
    case small
    case medium
    case large
    case extraLarge
    case extraExtraLarge
}

enum ColorSet {
    case primary
    case onPrimary
    case primaryDark
    case accent
    case background
}

enum FontScale {
    case h3
}
