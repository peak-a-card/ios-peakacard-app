import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import CombineFirebaseFirestore

class SessionRemoteDataSource {
    
    private let dataBase = Firestore.firestore()
    
    func join(code: String, participant: String) -> AnyPublisher<SessionDataModel, AsynchronousError> {
        return dataBase.collection("session")
            .document(code)
            .publisher(as: SessionParticipantsDataModel.self)
            .map { $0! }
            .mapError { _ in .itemNotFound }
            .flatMap { self.sessionParticipants($0) }
            .map { SessionDataModel(participants: $0) }
            .eraseToAnyPublisher()
    }

    private func sessionParticipants(_ participants: SessionParticipantsDataModel) -> AnyPublisher<[ParticipantDataModel], AsynchronousError> {
        return Publishers.MergeMany(participants.participants.map {
            $0.getDocument(as: ParticipantDataModel.self)
                .map { $0! }
                .mapError { _ in .itemNotFound }
                .eraseToAnyPublisher()
            })
            .collect()
            .eraseToAnyPublisher()
    }

    func verify(code: String) -> AnyPublisher<String, AsynchronousError> {
        return dataBase.collection("session")
            .document(code)
            .getDocument()
            .tryMap { snapshot in
                if snapshot.exists {
                    return code
                } else {
                    throw AsynchronousError.itemNotFound
                }
            }
            .mapError { _ in .itemNotFound }
            .eraseToAnyPublisher()
    }
}
