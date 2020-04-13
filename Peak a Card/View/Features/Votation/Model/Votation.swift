import Foundation

enum VotationStatus  {
    case started
    case ended
}

struct Votation {
    let name: String
    let votations: [Participant: Card]
    let status: VotationDomainStatus
    let alreadyVoted: Bool
    let creationDate: Date
}
