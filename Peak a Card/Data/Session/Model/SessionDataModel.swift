import Foundation

struct SessionDataModel: Codable {

    let participants: [String]
    let votations: [VotationDataModel]
}
