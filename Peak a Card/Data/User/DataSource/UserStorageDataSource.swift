import Foundation

class UserStorageDataSource {

    private let storage = UserDefaults.standard
    private let userKey = "com.app.peakacard.user"

    func get() -> UserDataModel? {
        guard let data = storage.data(forKey: userKey) else { return nil }
        do {
            return try UserDataModel.decode(from: data)
        } catch _ {
            return nil
        }
    }

    func set(user: UserDataModel) {
        let data = try! user.encode()
        storage.setValue(data, forKey: userKey)
    }
}
