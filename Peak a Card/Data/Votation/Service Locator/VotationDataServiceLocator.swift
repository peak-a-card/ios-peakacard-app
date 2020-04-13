import Foundation

class VotationDataServiceLocator: BaseDataServiceLocator {

    private lazy var repository: VotationsRepositoryProtocol = {
        return VotationsRepository(dataSource: VotationsRemoteDataSource())
    }()

    func provideVotationsRepository() -> VotationsRepositoryProtocol {
        return repository
    }
}
