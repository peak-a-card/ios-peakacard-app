import Foundation

enum AppAction {
    case doNothing
    case session(SessionAction)
    case participants(ParticipantsAction)
    case cards(CardsAction)
    case detail(CardAction)
    case votation(VotationAction)
}

enum SessionAction {
    case authenticatedWithGoogle(user: User)
    case start(code: String, user: User)
    case started(code: String)
    case failed(error: AsynchronousError)
    case participantLogout
    case exitSession
}

enum ParticipantsAction {
    case received(participants: [Participant])
    case failed
}

enum VotationAction {
    case getAll
    case received(votations: [Votation])
}

enum CardsAction {
    case get
    case select(card: Card)
}

enum CardAction {
    case dismiss
    case submit
}
