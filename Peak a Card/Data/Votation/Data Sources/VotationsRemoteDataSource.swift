import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import CombineFirebaseFirestore

class VotationsRemoteDataSource {

    private let dataBase = Firestore.firestore()

    func getAll(code: String) -> AnyPublisher<[VotationDataModel], AsynchronousError> {
        dataBase.collection("session")
            .document(code)
            .collection("votations")
            .publisher(as: VotationDataModel.self)
            .mapError { _ in AsynchronousError.itemNotFound }
            .eraseToAnyPublisher()
    }

    func submit(code: String, votationId: String, participantId: String, score: Float) -> AnyPublisher<Void, AsynchronousError> {
        dataBase.collection("session")
            .document(code)
            .collection("votations")
            .document(votationId)
            .setData(["participant_votation": [participantId: score]], merge: true)
            .mapError { error in AsynchronousError.unknown(error: error) }
            .eraseToAnyPublisher()
    }
}
