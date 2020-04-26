import Foundation

protocol UserRepositoryProtocol {
    func get() -> UserDataModel?
    func set(user: UserDataModel)
}

class UserRepository: UserRepositoryProtocol {

    private let dataSource: UserStorageDataSource

    init(dataSource: UserStorageDataSource) {
        self.dataSource = dataSource
    }

    func get() -> UserDataModel? {
        return dataSource.get()
    }

    func set(user: UserDataModel) {
        dataSource.set(user: user)
    }
}
