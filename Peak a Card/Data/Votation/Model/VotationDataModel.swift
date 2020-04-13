import Foundation

struct VotationDataModel: Codable {
    let name: String
    let votations: [String: Float]
    let status: String
    let creationDate: Date

    enum CodingKeys: String, CodingKey {
        case name
        case votations = "participant_votation"
        case status
        case creationDate
    }
}
