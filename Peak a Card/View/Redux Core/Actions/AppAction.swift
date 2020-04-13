import Foundation

enum AppAction {
    case session(SessionAction)
    case cards(CardsAction)
    case detail(CardAction)
}

enum SessionAction {
    case authenticatedWithGoogle(user: User)
    case start(code: String, user: User)
    case started(code: String)
    case failed(error: AsynchronousError)
}

enum CardsAction {
    case get
    case select(card: Card)
}

enum CardAction {
    case dismiss
    case submit
}
