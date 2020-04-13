import Foundation
import Combine

protocol SubmitVotationUseCase {
    func execute(code: String, votationId: String, participantId: String, score: Float) -> AnyPublisher<Void, AsynchronousError>
}

class SubmitVotation: SubmitVotationUseCase {

    private let repository: VotationsRepositoryProtocol

    init(repository: VotationsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(code: String, votationId: String, participantId: String, score: Float) -> AnyPublisher<Void, AsynchronousError> {
        return repository.submit(
            code: code,
            votationId: votationId,
            participantId: participantId,
            score: score
        )
    }
}
