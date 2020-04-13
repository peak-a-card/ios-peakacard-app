import Foundation
import Combine

protocol JoinSessionUseCase {
    func execute(code: String, user: UserDomainModel) -> AnyPublisher<Void, AsynchronousError>
}

class JoinSession: JoinSessionUseCase {

    private let repository: SessionRepositoryProtocol

    init(repository: SessionRepositoryProtocol) {
        self.repository = repository
    }

    func execute(code: String, user: UserDomainModel) -> AnyPublisher<Void, AsynchronousError> {
        return repository.join(code: code, user: user)
    }
}
