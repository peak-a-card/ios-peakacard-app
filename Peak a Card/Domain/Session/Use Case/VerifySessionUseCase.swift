import Foundation
import Combine

protocol VerifySessionUseCase {
    func execute(code: String) -> AnyPublisher<String, AsynchronousError>
}

class VerifySession: VerifySessionUseCase {

    private let repository: SessionRepositoryProtocol

    init(repository: SessionRepositoryProtocol) {
        self.repository = repository
    }

    func execute(code: String) -> AnyPublisher<String, AsynchronousError> {
        return repository.verify(code: code)
    }
}
