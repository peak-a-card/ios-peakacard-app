import SwiftUI
import Combine

struct AppState {

    // Session
    var isRequestingSession: Bool
    var sessionErrored: Bool

    var sessionId: String?
    var user: User?

    // Cards
    var cards: [Card]
    var selectedCard: Card?
}
