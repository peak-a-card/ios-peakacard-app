import Foundation

class UserDataServiceLocator: BaseDataServiceLocator {

    func provideRepository() -> UserRepositoryProtocol {
        return UserRepository(dataSource: UserStorageDataSource())
    }
}
