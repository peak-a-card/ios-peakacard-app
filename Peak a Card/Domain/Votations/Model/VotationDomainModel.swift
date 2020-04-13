import Foundation

enum VotationDomainStatus: String  {
    case started = "STARTED"
    case ended = "ENDED"
}

struct VotationDomainModel {
    let name: String
    let votations: [ParticipantDomainModel: CardDomainModel]
    let status: VotationDomainStatus
}
