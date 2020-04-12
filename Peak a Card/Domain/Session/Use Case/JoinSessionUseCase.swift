import Foundation
import Combine

protocol JoinSessionUseCase {
    func joinSession(code: String, participant: String) -> AnyPublisher<SessionDomainModel, AsynchronousError>
}

class JoinSession: JoinSessionUseCase {

    private let repository: SessionRepositoryProtocol

    init(repository: SessionRepositoryProtocol) {
        self.repository = repository
    }

    func joinSession(code: String, participant: String) -> AnyPublisher<SessionDomainModel, AsynchronousError> {
        return repository.join(code: code, participant: participant)
    }
}
