import SwiftUI

struct AppState {

    var sessionStarted: Bool
    var isRequestingSession: Bool

    var cards: [Card]
    var selectedCard: Card?
}
