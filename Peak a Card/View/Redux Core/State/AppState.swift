import SwiftUI
import Combine

struct AppState {

    var sessionStarted: Bool
    var isRequestingSession: Bool

    var cards: [Card]
    var selectedCard: Card?
}
