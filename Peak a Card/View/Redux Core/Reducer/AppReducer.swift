import Foundation
import Combine

typealias Effect = AnyPublisher<AppAction, Never>

func appReducer(state: inout AppState, action: AppAction) -> Effect? {
    switch action {
    case .session(let action):
        return reduce(state: &state, action: action)
    case .cards(let action):
        return reduce(state: &state, action: action)
    case .detail(let action):
        return reduce(state: &state, action: action)
    }
}

fileprivate func reduce(state: inout AppState, action: SessionAction) -> Effect? {
    switch action {
    case .authenticatedWithGoogle(let user):
        state.user = user
    case .start(let code, let user):
        state.isRequestingSession = true
        let userDomainModel = UserDomainModel(id: user.id, name: user.name, email: user.email)
        let joinSessionUseCase = DomainServiceLocator.shared.session.provideJoinSessionUseCase()
        return joinSessionUseCase.execute(code: code, user: userDomainModel)
            .map { AppAction.session(.started(code: code)) }
            .catch { error in Just(AppAction.session(.failed(error: error))) }
            .eraseToAnyPublisher()
    case .started(let code):
        state.isRequestingSession = false
        state.sessionErrored = false
        state.sessionId = code
    case .failed:
        state.sessionErrored = true
        state.isRequestingSession = false
    }
    return nil
}

fileprivate func reduce(state: inout AppState, action: CardsAction) -> Effect? {
    switch action {
    case .get:
        let getCardsUseCase = DomainServiceLocator.shared.cards.provideGetCardsUseCase()
        let cards = getCardsUseCase.getCards()
        state.cards = cards.map { Card(score: $0.score) }
    case .select(let card):
        state.selectedCard = card
    }
    return nil
}

fileprivate func reduce(state: inout AppState, action: CardAction) -> Effect? {
    switch action {
    case .dismiss:
        state.selectedCard = nil
    case .submit:
        // TODO: Send card
        state.selectedCard = nil
    }
    return nil
}
