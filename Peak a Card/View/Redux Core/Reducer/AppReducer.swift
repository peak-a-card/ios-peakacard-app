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
    case .doNothing:
        state.shouldWait = false
        return nil
    }

}

fileprivate func reduce(state: inout AppState, action: SessionAction) -> Effect? {
    switch action {
    case .endEditingSession(let code):
        state.currentCode = code
    case .authenticatingWithGoogle:
        state.shouldWait = true
    case .authenticatedWithGoogle(let user):
        state.user = user
        if let code = state.currentCode {
            return reduce(state: &state, action: .start(code: code, user: user))
        }
    case .start(let code, let user):
        state.isRequestingSession = true
        let userDomainModel = UserDomainModel(id: user.id, name: user.name, email: user.email)
        let joinSessionUseCase = DomainServiceLocator.shared.session.provideJoinSessionUseCase()
        return joinSessionUseCase.execute(code: code, user: userDomainModel)
            .map { AppAction.session(.started(code: code)) }
            .catch { error in Just(AppAction.session(.failed(error: error))) }
            .eraseToAnyPublisher()
    case .started(let code):
        state.shouldWait = false
        state.isRequestingSession = false
        state.sessionErrored = false
        state.sessionId = code
        state.waitingForParticipants = true
        let getAllParticipantsUseCase = DomainServiceLocator.shared.participants.provideGetAllParticipantsUseCase()
        return getAllParticipantsUseCase.execute(code: code)
            .map { participants in
                let models = participants.map { Participant(id: $0.id, name: $0.name) }
                return AppAction.participants(.received(participants: models))
            }
        .catch { _ in Just(AppAction.participants(.failed)) }
        .eraseToAnyPublisher()
    case .failed:
        state.shouldWait = false
        state.sessionErrored = true
        state.isRequestingSession = false
    case .participantLogout:
        guard let code = state.sessionId, let userId = state.user?.id else { return nil }
        state.shouldWait = true
        let removeParticipantUseCase = DomainServiceLocator.shared.participants.provideRemoveParticipantUseCase()
        return removeParticipantUseCase.execute(code: code, id: userId)
            .map { AppAction.session(.exitSession) }
            .catch { _ in Just(AppAction.doNothing) }
            .eraseToAnyPublisher()
    case .exitSession:
        state.shouldWait = false
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
        guard let code = state.sessionId, let userId = state.user?.id else { return nil }
        let getAllVotationsUseCase = DomainServiceLocator.shared.votations.provideGetAllVotationsUseCase()
        return getAllVotationsUseCase.execute(code: code, userId: userId)
            .map { votations in
                votations.map {
                    var results: [ParticipantVotation] = []

                    $0.votations.forEach {
                        let participantVotation = ParticipantVotation(
                            participant: Participant(id: $0.participant.id, name: $0.participant.name),
                            card: Card(score: $0.card.score)
                        )
                        results.append(participantVotation)
                    }

                    let scores = results.map { $0.card.id.score }
                    let modes = scores.mode().map { Card(score: $0) }

                    return Votation(
                        name: $0.name,
                        votations: results,
                        status: $0.status == .started ? .started : .ended,
                        alreadyVoted: $0.alreadyVoted,
                        mode: modes,
                        creationDate: $0.creationDate
                    ) }
        }
        .map { AppAction.votation(.received(votations: $0)) }
        .catch { _ in Just(AppAction.doNothing) }
        .eraseToAnyPublisher()
    case .received(let votations):
        state.startedVotations = votations.filter { $0.status == .started }
        state.endedVotations = votations.filter { $0.status == .ended }
        state.waitingForParticipants = state.startedVotations.isEmpty && state.endedVotations.isEmpty
    case .edit:
        state.edit = true
    }
    return nil
}

fileprivate func reduce(state: inout AppState, action: CardsAction) -> Effect? {
    switch action {
    case .getAll:
        let getCardsUseCase = DomainServiceLocator.shared.cards.provideGetCardsUseCase()
        return getCardsUseCase.getAll()
            .map { $0.map { Card(score: $0.score) } }
            .map { AppAction.cards(.received(cards: $0)) }
            .catch { _ in Just(AppAction.doNothing) }
            .eraseToAnyPublisher()
    case .received(let cards):
        state.cards = cards
    case .select(let card):
        state.selectedCard = card
        state.shouldWait = false
    }
    return nil
}

fileprivate func reduce(state: inout AppState, action: CardAction) -> Effect? {
    switch action {
    case .dismiss:
        state.selectedCard = nil
    case .submit:
        var targetVotationId: String?
        if state.startedVotations.last?.name != nil {
            targetVotationId = state.startedVotations.last?.name
        } else {
            targetVotationId = state.lastVotedVotation?.name
        }
        guard
            let code = state.sessionId,
            let votationId = targetVotationId,
            let userId = state.user?.id,
            let card = state.selectedCard else { return nil }
        state.shouldWait = true
        state.selectedCard = nil
        state.edit = false
        let submitVotationUseCase = DomainServiceLocator.shared.votations.provideSubmitVotationUseCase()
        return submitVotationUseCase.execute(code: code, votationId: votationId, participantId: userId, score: card.id.score)
            .map { AppAction.doNothing }
            .catch { error in Just(AppAction.cards(.select(card: card))) }
            .eraseToAnyPublisher()
    }
    return nil
}
