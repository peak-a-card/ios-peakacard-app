import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import CombineFirebaseFirestore

class SessionRemoteDataSource {
    
    private let dataBase = Firestore.firestore()
    
    func join(code: String, user: UserDataModel) -> AnyPublisher<Void, AsynchronousError> {
        return verify(code: code)
            .mapError { _ in AsynchronousError.itemNotFound }
            .flatMap { code in
                self.dataBase.collection("session")
                .document(code)
                .collection("participants")
                .document(user.id)
                .setData(from: user.information)
                .eraseToAnyPublisher()
            }
        .mapError { _ in AsynchronousError.itemNotFound }
        .eraseToAnyPublisher()
    }

//    private func sessionParticipants(_ participants: SessionParticipantsDataModel) -> AnyPublisher<[ParticipantDataModel], AsynchronousError> {
//        return Publishers.MergeMany(participants.participants.map {
//            $0.getDocument(as: ParticipantDataModel.self)
//                .map { $0! }
//                .mapError { _ in .itemNotFound }
//                .eraseToAnyPublisher()
//            })
//            .collect()
//            .eraseToAnyPublisher()
//    }

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
