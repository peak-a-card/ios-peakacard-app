import SwiftUI

extension Color {
    static let primary = Color("Primary")
    static let primaryDark = Color("PrimaryDark")
    static let accent = Color("Accent")
    static let background = Color("Background")
    static let onPrimary = Color("onPrimary")
}

extension UIColor {

    convenience init(named: String) {
        self.init(named: named)!
    }

    static let primary = UIColor(named: "Primary")
    static let primaryDark = UIColor(named: "PrimaryDark")
    static let accent = UIColor(named: "Accent")
    static let background = UIColor(named: "Background")
    static let onPrimary = UIColor(named: "onPrimary")
}
