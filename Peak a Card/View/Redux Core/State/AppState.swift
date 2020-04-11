import SwiftUI
import Combine

struct AppState {

    // Session
    var session: Session?
    var isRequestingSession: Bool
    var sessionErrored: Bool

    // Cards
    var cards: [Card]
    var selectedCard: Card?
}
