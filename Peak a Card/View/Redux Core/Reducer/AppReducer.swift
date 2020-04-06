import Foundation

func appReducer(state: AppState, action: AppAction) -> AppState {
    var state = state
    switch action {
    case .session(let action):
        state = reduce(state: &state, action: action)
    case .cards(let action):
        state = reduce(state: &state, action: action)
    case .detail(let action):
        state = reduce(state: &state, action: action)
    }
    return state
}

fileprivate func reduce(state: inout AppState, action: SessionAction) -> AppState {
    switch action {
    case .start:
        state.isRequestingSession = true
        state.sessionStarted = true
    }
    return state
}

fileprivate func reduce(state: inout AppState, action: CardsAction) -> AppState {
    switch action {
    case .get:
        let getCardsUseCase = DomainServiceLocator.shared.cards.provideGetCardsUseCase()
        let cards = getCardsUseCase.getCards()
        state.cards = cards.map { Card(score: $0.score) }
    case .select(let card):
        state.selectedCard = card
    }
    return state
}

fileprivate func reduce(state: inout AppState, action: CardAction) -> AppState {
    switch action {
    case .dismiss:
        state.selectedCard = nil
    case .submit:
        // TODO: Send card
        state.selectedCard = nil
    }
    return state
}
