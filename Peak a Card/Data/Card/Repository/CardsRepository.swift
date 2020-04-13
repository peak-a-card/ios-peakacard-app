import Foundation
import Combine

protocol CardsRepositoryProtocol {
    func getAll() -> AnyPublisher<[CardDataModel], AsynchronousError>
}

class CardsRepository: CardsRepositoryProtocol {

    private let dataSource: InMemoryCardsDataSource

    init(dataSource: InMemoryCardsDataSource) {
        self.dataSource = dataSource
    }

    func getAll() -> AnyPublisher<[CardDataModel], AsynchronousError> {
        return Just(dataSource.get())
            .mapError { _ in AsynchronousError.itemNotFound }
            .eraseToAnyPublisher()
    }
}
