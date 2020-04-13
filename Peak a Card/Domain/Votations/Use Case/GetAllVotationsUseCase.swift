import Foundation
import Combine

protocol GetAllVotationsUseCase {
    func execute(code: String) -> AnyPublisher<[VotationDomainModel], AsynchronousError>
}

class GetAllVotations: GetAllVotationsUseCase {

    private let votationsRepository: VotationsRepositoryProtocol
    private let participantsRepository: ParticipantsRepositoryProtocol
    private let cardsRepository: CardsRepositoryProtocol

    init(votationsRepository: VotationsRepositoryProtocol,
         participantsRepository: ParticipantsRepositoryProtocol,
         cardsRepository: CardsRepositoryProtocol) {
        self.votationsRepository = votationsRepository
        self.participantsRepository = participantsRepository
        self.cardsRepository = cardsRepository
    }

    func execute(code: String) -> AnyPublisher<[VotationDomainModel], AsynchronousError> {
        return Publishers.CombineLatest3(
            votationsRepository.getAll(code: code),
            participantsRepository.getAll(code: code),
            cardsRepository.getAll()
        ).map { votations, participants, cards in
            return votations.map {
                var results: [ParticipantDomainModel: CardDomainModel] = [:]
                $0.votations.forEach { key, value in
                    let participantDataModel = participants.first { $0.id == key }
                    let cardDataModel = cards.first { $0.score == value }
                    if let participantDataModel = participantDataModel, let cardDataModel = cardDataModel {
                        let participant = ParticipantDomainModel(id: participantDataModel.id, name: participantDataModel.name, email: participantDataModel.email)
                        let card = CardDomainModel(score: cardDataModel.score)
                        results[participant] = card
                    }
                }

                return VotationDomainModel(
                    name: $0.name,
                    votations: results,
                    status: VotationDomainStatus(rawValue: $0.status) ?? .ended
                )
            }
        }.eraseToAnyPublisher()
    }
}
