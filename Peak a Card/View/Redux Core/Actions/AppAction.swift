import Foundation

enum AppAction {
    case session(SessionAction)
    case cards(CardsAction)
    case detail(CardAction)
}

enum SessionAction {
    case start
}

enum CardsAction {
    case get
    case select(card: Card)
}

enum CardAction {
    case dismiss
    case submit
}
