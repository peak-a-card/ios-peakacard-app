import Foundation

enum AppAction {
    case session(SessionAction)
    case cards(CardsAction)
    case detail(CardAction)
}

enum SessionAction {
    case start(code: String, participant: String)
    case started(session: SessionDomainModel)
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
