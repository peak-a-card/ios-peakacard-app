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
            .map { participants -> [ParticipantDomainModel] in
                participants.map {
                    ParticipantDomainModel(id: $0.id, name: $0.name, email: $0.email)
                }
        }
        .eraseToAnyPublisher()
    }
}
