import Foundation
import Combine

protocol JoinSessionRepositoryProtocol {
    func joinSession(code: String, participant: String) -> AnyPublisher<SessionDomainModel, AsynchronousError>
}

class JoinSessionRepository: JoinSessionRepositoryProtocol {

    private let dataSource: JoinSessionRemoteDataSource

    init(dataSource: JoinSessionRemoteDataSource) {
        self.dataSource = dataSource
    }

    func joinSession(code: String, participant: String) -> AnyPublisher<SessionDomainModel, AsynchronousError> {
        return dataSource.joinSession(code: code, participant: participant)
            .map { SessionDomainModel(participants: $0.participants.map { ParticipantDomainModel(name: $0.name) }) }
            .eraseToAnyPublisher()
    }
}
