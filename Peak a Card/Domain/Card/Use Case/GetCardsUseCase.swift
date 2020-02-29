import Foundation

class GetCardsUseCase {

    private let cardsRepository: CardsRepository

    init(cardsRepository: CardsRepository) {
        self.cardsRepository = cardsRepository
    }

    func getCards() -> [CardDomainModel] {
        return cardsRepository.getCards()
    }
}
