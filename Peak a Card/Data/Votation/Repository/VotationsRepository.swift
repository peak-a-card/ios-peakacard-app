import Foundation
import Combine

protocol VotationsRepositoryProtocol {
    func getAll(code: String) -> AnyPublisher<[VotationDomainModel], AsynchronousError>
}

class VotationsRepository: VotationsRepositoryProtocol {

    private let dataSource: VotationsRemoteDataSource

    init(dataSource: VotationsRemoteDataSource) {
        self.dataSource = dataSource
    }

    func getAll(code: String) -> AnyPublisher<[VotationDomainModel], AsynchronousError> {
        return dataSource.getAll(code: code)
            .map { votations in
                votations.map {
                    VotationDomainModel(
                        name: $0.name,
                        votations: $0.votations,
                        status: VotationDomainStatus(rawValue: $0.status) ?? .ended
                    )
                }
        }.eraseToAnyPublisher()
    }
}
