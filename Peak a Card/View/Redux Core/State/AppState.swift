import SwiftUI
import Combine

struct AppState {

    // Session
    var isRequestingSession: Bool = false
    var sessionErrored: Bool = false

    var sessionId: String? = nil
    var user: User? = nil

    // Cards
    var cards: [Card] = []
    var selectedCard: Card? = nil

    // Participants
    var waitingForParticipants = false
    var participants: [Participant] = []

    // Votations
    var allVotations: [Votation] {
        startedVotations + endedVotations
    }
    var startedVotations: [Votation] = []
    var endedVotations: [Votation] = []

    // Effects Bag
    var cancelBag = Set<AnyCancellable>()
}
