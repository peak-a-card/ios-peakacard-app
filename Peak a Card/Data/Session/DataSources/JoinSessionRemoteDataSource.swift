import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import CombineFirebaseFirestore

class JoinSessionRemoteDataSource {
    
    private let dataBase = Firestore.firestore()
    
    func joinSession(code: String, participant: String) -> AnyPublisher<SessionDataModel, AsynchronousError> {
        return dataBase.collection("sessions")
            .document(code)
            .publisher(as: SessionParticipantsDataModel.self)
            .map { $0! }
            .mapError { _ in AsynchronousError.sessionNotFound }
            .flatMap { self.sessionParticipants($0) }
            .map { SessionDataModel(participants: $0) }
            .eraseToAnyPublisher()
    }

    private func sessionParticipants(_ participants: SessionParticipantsDataModel) -> AnyPublisher<[ParticipantDataModel], AsynchronousError> {
        return Publishers.MergeMany(participants.participants.map {
            $0.getDocument(as: ParticipantDataModel.self)
                .map { $0! }
                .mapError { _ in AsynchronousError.sessionNotFound }
                .eraseToAnyPublisher()
            })
            .collect()
            .eraseToAnyPublisher()
    }
}
