import Foundation

struct UserDataModel {
    let id: String
    let information: UserInformationDataModel
}

struct UserInformationDataModel: Codable {
    let name: String
    let email: String
}
