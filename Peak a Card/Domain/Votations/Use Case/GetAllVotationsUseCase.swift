import Foundation
import Combine

protocol GetAllVotationsUseCase {
    func execute(code: String) -> AnyPublisher<[VotationDomainModel], AsynchronousError>
}

class GetAllVotations: GetAllVotationsUseCase {

    private let repository: VotationsRepositoryProtocol

    init(repository: VotationsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(code: String) -> AnyPublisher<[VotationDomainModel], AsynchronousError> {
        return repository.getAll(code: code)
    }
}
