import Foundation

enum VotationDomainStatus: String  {
    case started = "STARTED"
    case ended = "ENDED"
}

struct VotationDomainModel {
    let name: String
    let votations: [ParticipantDomainModel: CardDomainModel]
    let status: VotationDomainStatus
    let alreadyVoted: Bool
    let creationDate: Date
}
