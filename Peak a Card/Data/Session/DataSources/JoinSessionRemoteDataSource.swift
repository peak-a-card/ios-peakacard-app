import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class JoinSessionRemoteDataSource {
    
    private let dataBase = Firestore.firestore()
    
    func joinSession(code: String, participant: String) -> AnyPublisher<SessionDataModel, AsynchronousError> {
        return Future<SessionDataModel, AsynchronousError> { [weak self] promise in
            self?.dataBase.collection("session")
                .document(code)
                .getDocument(completion: { snapshot, error in
                    if let error = error {
                        promise(.failure(.unknown(error: error)))
                    } else if let snapshot = snapshot {
                        do {
                            if let session = try snapshot.data(as: SessionDataModel.self) {
                                promise(.success(session))
                            } else {
                                promise(.failure(.parsing))
                            }
                        } catch {
                            promise(.failure(.parsing))
                        }
                    } else {
                        promise(.failure(.sessionNotFound))
                    }
                })
        }.eraseToAnyPublisher()
    }
}
