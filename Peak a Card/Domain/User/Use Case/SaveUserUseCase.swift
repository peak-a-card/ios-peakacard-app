import Foundation

protocol SaveUserUseCase {
    func execute(user: UserDomainModel)
}

class SaveUser: SaveUserUseCase {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute(user: UserDomainModel) {
        let userDataModel = UserDataModel(id: user.id, name: user.name, email: user.email)
        repository.set(user: userDataModel)
    }
}
