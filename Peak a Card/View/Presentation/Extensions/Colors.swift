import SwiftUI

extension Color {
    static let primary = Color("Primary")
    static let primary10 = Color("Primary10")
    static let secondary = Color("Secondary")
    static let background = Color("Background")
    static let onPrimary = Color("onPrimary")
    static let error = Color("Error")
    static let success = Color("Success")
}

extension UIColor {

    convenience init(named: String) {
        self.init(named: named)!
    }

    static let primary = UIColor(named: "Primary")
    static let primary10 = UIColor(named: "Primary10")
    static let secondary = UIColor(named: "Secondary")
    static let background = UIColor(named: "Background")
    static let onPrimary = UIColor(named: "onPrimary")
    static let error = UIColor(named: "Error")
    static let success = UIColor(named: "Success")
}
