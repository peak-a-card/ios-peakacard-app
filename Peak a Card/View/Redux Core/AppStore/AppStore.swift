import Foundation
import Combine

final class AppStore: ObservableObject {
    @Published private(set) var state: AppState
    private var cancelBag = Set<AnyCancellable>()

    init(state: AppState) {
        self.state = state
    }

    convenience init() {
        let state = AppState(
            isRequestingSession: false,
            sessionErrored: false,
            sessionId: nil,
            user: nil,
            cards: [],
            selectedCard: nil
        )
        self.init(state: state)
    }

    public func dispatch(action: AppAction) {
        guard let effect = appReducer(state: &state, action: action) else { return }

        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // Do I need to do something here?
            }, receiveValue: dispatch)
            .store(in: &cancelBag)
    }
}
