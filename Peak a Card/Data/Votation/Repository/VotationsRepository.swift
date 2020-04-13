import Foundation
import Combine

protocol VotationsRepositoryProtocol {
    func getAll(code: String) -> AnyPublisher<[VotationDataModel], AsynchronousError>
    func submit(code: String, votationId: String, participantId: String, score: Float) -> AnyPublisher<Void, AsynchronousError>
}

class VotationsRepository: VotationsRepositoryProtocol {

    private let dataSource: VotationsRemoteDataSource

    init(dataSource: VotationsRemoteDataSource) {
        self.dataSource = dataSource
    }

    func getAll(code: String) -> AnyPublisher<[VotationDataModel], AsynchronousError> {
        return dataSource.getAll(code: code)
    }

    func submit(code: String, votationId: String, participantId: String, score: Float) -> AnyPublisher<Void, AsynchronousError> {
        return dataSource.submit(code: code, votationId: votationId, participantId: participantId, score: score)
    }
}
