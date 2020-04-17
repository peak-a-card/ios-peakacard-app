import Foundation
import Combine

protocol RemoveParticipantUseCase {
    func execute(code: String, id: String) -> AnyPublisher<Void, AsynchronousError>
}

class RemoveParticipant: RemoveParticipantUseCase {

    private let repository: ParticipantsRepositoryProtocol

    init(repository: ParticipantsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(code: String, id: String) -> AnyPublisher<Void, AsynchronousError> {
        return repository.remove(code: code, id: id)
    }
}
