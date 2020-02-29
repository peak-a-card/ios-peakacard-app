import Foundation

protocol GetCardsUseCase {
    func getCards() -> [CardDomainModel]
}

class GetCards: GetCardsUseCase {

    private let cardsRepository: CardsRepositoryProtocol

    init(cardsRepository: CardsRepositoryProtocol) {
        self.cardsRepository = cardsRepository
    }

    func getCards() -> [CardDomainModel] {
        return cardsRepository.getCards()
    }
}
