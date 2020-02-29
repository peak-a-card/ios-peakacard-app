import Foundation

class CardsDomainServiceLocator: BaseDomainServiceLocator {

    func provideGetCardsUseCase() -> GetCardsUseCase {
        return GetCards(cardsRepository: root.data.cards.provideCardsRepository())
    }
}
