import Foundation

class UserDomainServiceLocator: BaseDomainServiceLocator {

    func provideGetUserUseCase() -> GetUserUseCase {
        return GetUser(repository: root.data.user.provideRepository())
    }

    func provideSaveUserUseCase() -> SaveUserUseCase {
        return SaveUser(repository: root.data.user.provideRepository())
    }
}
