import Foundation

class SessionDataServiceLocator: BaseDataServiceLocator {

    private lazy var repository: SessionRepositoryProtocol = {
        return SessionRepository(dataSource: SessionRemoteDataSource())
    }()

    func provideSessionRepository() -> SessionRepositoryProtocol {
        return repository
    }
}
