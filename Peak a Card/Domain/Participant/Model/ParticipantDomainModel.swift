import Foundation

struct ParticipantDomainModel: Hashable {
    let id: String
    let name: String
    let email: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
