import Foundation

struct VotationDataModel: Codable {
    let name: String
    let votations: [String: String]
    let status: String

    enum CodingKeys: String, CodingKey {
        case name
        case votations = "participant_votation"
        case status
    }
}
