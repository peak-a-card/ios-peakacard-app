import Foundation

class CardsDataServiceLocator: BaseDataServiceLocator {

    private lazy var repository: CardsRepositoryProtocol = {
        let memoryDataSource = InMemoryCardsDataSource()
        return CardsRepository(dataSource: memoryDataSource)
    }()

    func provideCardsRepository() -> CardsRepositoryProtocol {
        return repository
    }
}
