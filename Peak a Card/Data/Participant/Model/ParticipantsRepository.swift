import Foundation
import Combine

protocol ParticipantsRepositoryProtocol {
    func getAll(code: String) -> AnyPublisher<[ParticipantDomainModel], AsynchronousError>
}

class ParticipantsRepository: ParticipantsRepositoryProtocol {

    private let dataSource: ParticipantRemoteDataSource

    init(dataSource: ParticipantRemoteDataSource) {
        self.dataSource = dataSource
    }

    func getAll(code: String) -> AnyPublisher<[ParticipantDomainModel], AsynchronousError> {
        return dataSource.getAll(code: code)
            .map { participants -> [ParticipantDomainModel] in
                participants.map {
                    ParticipantDomainModel(name: $0.name, email: $0.email)
                }
            }
        .eraseToAnyPublisher()
    }
}
