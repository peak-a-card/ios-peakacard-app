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
//    case .start(let code, let participant):
//        state.isRequestingSession = true
//        let joinSessionUseCase = DomainServiceLocator.shared.session.provideJoinSessionUseCase()
//        return joinSessionUseCase.joinSession(code: code, participant: participant)
//            .map { AppAction.session(.started(session: $0)) }
//            .catch { error in Just(AppAction.session(.failed(error: error))) }
//            .eraseToAnyPublisher()
    case .authenticatedWithGoogle(let user):
        state.user = user
    case .start(let code, let user):
        break
    case .verifySession(let code):
        state.sessionErrored = false
        state.sessionId = nil
        state.isRequestingSession = true
        let verifySessionUseCase = DomainServiceLocator.shared.session.provideVerifySessionUseCase()
        return verifySessionUseCase.execute(code: code)
            .map { _ in AppAction.session(.sessionVerified(session: code)) }
            .catch { error in Just(AppAction.session(.failed(error: error))) }
            .eraseToAnyPublisher()
    case .sessionVerified(let session):
        state.sessionId = session
        state.isRequestingSession = false
        state.sessionErrored = false
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
