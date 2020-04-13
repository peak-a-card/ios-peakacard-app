import Foundation
import Combine

protocol GetCardsUseCase {
    func getAll() -> AnyPublisher<[CardDomainModel], AsynchronousError>
}

class GetCards: GetCardsUseCase {

    private let cardsRepository: CardsRepositoryProtocol

    init(cardsRepository: CardsRepositoryProtocol) {
        self.cardsRepository = cardsRepository
    }

    func getAll() -> AnyPublisher<[CardDomainModel], AsynchronousError> {
        return cardsRepository.getAll()
            .map { $0.map { CardDomainModel(score: $0.score) } }
            .eraseToAnyPublisher()
    }
}
