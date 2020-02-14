import Foundation

enum Theme {
    static var current: StylesheetTheme.Type = MainTheme.self
}

var Stylesheet: StylesheetTheme.Type {
    return Theme.current
}
