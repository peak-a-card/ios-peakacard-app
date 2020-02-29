import Foundation

enum AppAction {
    case cards(CardsAction)
    case detail(CardAction)
}

enum CardsAction {
    case get
    case select(card: Card)
}

enum CardAction {
    case unselect
    case submit(card: Card)
}
