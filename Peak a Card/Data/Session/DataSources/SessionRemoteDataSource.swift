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
                .setData(from: user)
                .eraseToAnyPublisher()
            }
        .mapError { _ in AsynchronousError.itemNotFound }
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
