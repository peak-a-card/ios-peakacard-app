import Foundation

struct Participant: Identifiable, Hashable {
    var id: String
    let name: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
