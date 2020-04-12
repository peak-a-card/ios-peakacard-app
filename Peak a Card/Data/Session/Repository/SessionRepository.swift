import Foundation
import Combine

protocol SessionRepositoryProtocol {
    func join(code: String, participant: String) -> AnyPublisher<SessionDomainModel, AsynchronousError>
    func verify(code: String) -> AnyPublisher<String, AsynchronousError>
}

class SessionRepository: SessionRepositoryProtocol {

    private let dataSource: SessionRemoteDataSource

    init(dataSource: SessionRemoteDataSource) {
        self.dataSource = dataSource
    }

    func join(code: String, participant: String) -> AnyPublisher<SessionDomainModel, AsynchronousError> {
        return dataSource.join(code: code, participant: participant)
            .map { SessionDomainModel(participants: $0.participants.map { ParticipantDomainModel(name: $0.name) }) }
            .eraseToAnyPublisher()
    }

    func verify(code: String) -> AnyPublisher<String, AsynchronousError> {
        return dataSource.verify(code: code)
    }
}
