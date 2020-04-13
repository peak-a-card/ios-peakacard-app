import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import CombineFirebaseFirestore

class ParticipantRemoteDataSource {

    private let dataBase = Firestore.firestore()

    func getAll(code: String) -> AnyPublisher<[ParticipantDataModel], AsynchronousError> {
        dataBase.collection("session")
            .document(code)
            .collection("participants")
            .publisher(as: ParticipantDataModel.self)
            .mapError { AsynchronousError.unknown(error: $0) }
            .eraseToAnyPublisher()
    }

    func remove(code: String, id: String) -> AnyPublisher<Void, AsynchronousError> {
        dataBase.collection("session")
            .document(code)
            .collection("participants")
            .document(id)
            .delete()
            .mapError { error in AsynchronousError.unknown(error: error) }
            .eraseToAnyPublisher()
    }
}
