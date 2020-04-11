import Foundation
import FirebaseFirestore

struct SessionParticipantsDataModel: Codable {
    let participants: [DocumentReference]
}
