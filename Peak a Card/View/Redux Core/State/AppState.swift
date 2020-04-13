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
    var startedVotations: [Votation] = []
    var endedVotations: [Votation] = []
    var lastVotedVotation: Votation? {
        let votation = startedVotations.first { $0.alreadyVoted }
        if votation == nil {
            return endedVotations.first { $0.alreadyVoted }
        }
        return votation
    }

    // Effects Bag
    var cancelBag = Set<AnyCancellable>()
}
