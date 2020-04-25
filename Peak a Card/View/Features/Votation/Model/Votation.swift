import Foundation

enum VotationStatus  {
    case started
    case ended
}

struct Votation {
    let name: String
    let votations: [ParticipantVotation]
    let status: VotationDomainStatus
    let alreadyVoted: Bool
    let creationDate: Date
}
