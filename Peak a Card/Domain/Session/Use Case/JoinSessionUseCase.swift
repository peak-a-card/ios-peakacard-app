import Foundation
import Combine

protocol JoinSessionUseCase {
    func joinSession(code: String, participant: String) -> AnyPublisher<SessionDomainModel, AsynchronousError>
}

class JoinSession: JoinSessionUseCase {

    private let repository: JoinSessionRepositoryProtocol

    init(repository: JoinSessionRepositoryProtocol) {
        self.repository = repository
    }

    func joinSession(code: String, participant: String) -> AnyPublisher<SessionDomainModel, AsynchronousError> {
        return repository.joinSession(code: code, participant: participant)
    }
}
