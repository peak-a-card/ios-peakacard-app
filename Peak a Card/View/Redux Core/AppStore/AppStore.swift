import Foundation
import Combine

final class AppStore: ObservableObject {
    @Published private(set) var state: AppState

    init(state: AppState) {
        self.state = state
    }

    convenience init() {
        let state = AppState()
        self.init(state: state)
    }

    public func dispatch(action: AppAction) {
        guard let effect = appReducer(state: &state, action: action) else { return }

        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // Do I need to do something here?
            }, receiveValue: dispatch)
            .store(in: &state.cancelBag)
    }
}
