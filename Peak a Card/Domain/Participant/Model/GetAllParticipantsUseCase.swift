import Foundation
import Combine

protocol GetAllParticipantsUseCase {
    func execute(code: String) -> AnyPublisher<[ParticipantDomainModel], AsynchronousError>
}

class GetAllParticipants: GetAllParticipantsUseCase {

    private let repository: ParticipantsRepositoryProtocol

    init(repository: ParticipantsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(code: String) -> AnyPublisher<[ParticipantDomainModel], AsynchronousError> {
        return repository.getAll(code: code)
    }
}
