import Foundation

enum VotationStatus  {
    case started
    case ended
}

struct Votation {
    let name: String
    let votations: [String: String]
    let status: VotationDomainStatus
}
