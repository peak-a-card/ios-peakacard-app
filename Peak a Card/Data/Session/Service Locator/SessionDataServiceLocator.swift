import Foundation

class SessionDataServiceLocator: BaseDataServiceLocator {

    private lazy var repository: JoinSessionRepositoryProtocol = {
        return JoinSessionRepository(dataSource: JoinSessionRemoteDataSource())
    }()

    func provideSessionRepository() -> JoinSessionRepositoryProtocol {
        return repository
    }
}
