import Foundation

protocol CardsRepositoryProtocol {
    func getCards() -> [CardDomainModel]
}

class CardsRepository: CardsRepositoryProtocol {

    private let dataSource: InMemoryCardsDataSource

    init(dataSource: InMemoryCardsDataSource) {
        self.dataSource = dataSource
    }

    func getCards() -> [CardDomainModel] {
        dataSource.get().map { CardDomainModel(score: $0.score) }
    }
}
