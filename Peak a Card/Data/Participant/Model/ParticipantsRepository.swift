import Foundation
import Combine

protocol ParticipantsRepositoryProtocol {
    func get(code: String, id: String) -> AnyPublisher<ParticipantDataModel, AsynchronousError>
    func getAll(code: String) -> AnyPublisher<[ParticipantDataModel], AsynchronousError>
    func remove(code: String, id: String) -> AnyPublisher<Void, AsynchronousError>
}

class ParticipantsRepository: ParticipantsRepositoryProtocol {

    private let dataSource: ParticipantRemoteDataSource

    init(dataSource: ParticipantRemoteDataSource) {
        self.dataSource = dataSource
    }

    func get(code: String, id: String) -> AnyPublisher<ParticipantDataModel, AsynchronousError> {
        return dataSource.get(code: code, id: id)
    }

    func getAll(code: String) -> AnyPublisher<[ParticipantDataModel], AsynchronousError> {
        return dataSource.getAll(code: code)
    }

    func remove(code: String, id: String) -> AnyPublisher<Void, AsynchronousError> {
        return dataSource.remove(code: code, id: id)
    }
}
