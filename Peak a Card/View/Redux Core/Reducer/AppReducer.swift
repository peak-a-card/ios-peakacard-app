import Foundation
import Combine

typealias Effect = AnyPublisher<AppAction, Never>

func appReducer(state: inout AppState, action: AppAction) -> Effect? {
    switch action {
    case .session(let action):
        return reduce(state: &state, action: action)
    case .participants(let action):
        return reduce(state: &state, action: action)
    case .votation(let action):
        return reduce(state: &state, action: action)
    case .cards(let action):
        return reduce(state: &state, action: action)
    case .detail(let action):
        return reduce(state: &state, action: action)
    case .doNothing: return nil
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
        state.waitingForParticipants = true
        let getAllParticipantsUseCase = DomainServiceLocator.shared.participants.provideGetAllParticipantsUseCase()
        return getAllParticipantsUseCase.execute(code: code)
            .map { participants in
                let models = participants.map { Participant(id: $0.email, name: $0.name) }
                return AppAction.participants(.received(participants: models))
            }
        .catch { _ in Just(AppAction.participants(.failed)) }
        .eraseToAnyPublisher()
    case .failed:
        state.sessionErrored = true
        state.isRequestingSession = false
    case .participantLogout:
        guard let code = state.sessionId, let userId = state.user?.id else { return nil }
        let removeParticipantUseCase = DomainServiceLocator.shared.participants.provideRemoveParticipantUseCase()
        return removeParticipantUseCase.execute(code: code, id: userId)
            .map { AppAction.session(.exitSession) }
            .catch { _ in Just(AppAction.doNothing) }
            .eraseToAnyPublisher()
    case .exitSession:
        state.cancelBag.forEach { $0.cancel() }
        state.isRequestingSession = false
        state.sessionErrored = false
        state.sessionId = nil
        state.waitingForParticipants = false
        state.participants = []
        state.startedVotations = []
        state.endedVotations = []
    }
    return nil
}

fileprivate func reduce(state: inout AppState, action: ParticipantsAction) -> Effect? {
    switch action {
    case .received(let participants):
        state.participants = participants
    case .failed:
        break
    }
    return nil
}

fileprivate func reduce(state: inout AppState, action: VotationAction) -> Effect? {
    switch action {
    case .getAll:
        guard let code = state.sessionId else { return nil }
        let getAllVotationsUseCase = DomainServiceLocator.shared.votations.provideGetAllVotationsUseCase()
        return getAllVotationsUseCase.execute(code: code)
            .map { votations in
                votations.map { Votation(name: $0.name, votations: $0.votations, status: $0.status == .started ? .started : .ended) }
        }
        .map { AppAction.votation(.received(votations: $0)) }
        .catch { _ in Just(AppAction.doNothing) }
        .eraseToAnyPublisher()
    case .received(let votations):
        state.startedVotations = votations.filter { $0.status == .started }
        state.endedVotations = votations.filter { $0.status == .ended }
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
