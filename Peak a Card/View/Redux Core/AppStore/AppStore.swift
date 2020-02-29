import Foundation

final class AppStore: ObservableObject {
    @Published private(set) var state: AppState

    init(state: AppState) {
        self.state = state
    }

    convenience init() {
        let state = AppState(cards: [], selectedCard: nil)
        self.init(state: state)
    }

    public func dispatch(action: AppAction) {
        state = appReducer(state: state, action: action)
    }
}
