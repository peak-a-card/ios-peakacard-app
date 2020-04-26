import Foundation

protocol GetUserUseCase {
    func execute() -> UserDomainModel?
}

class GetUser: GetUserUseCase {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> UserDomainModel? {
        return repository.get().map { UserDomainModel(id: $0.id, name: $0.name, email: $0.email) }
    }
}
