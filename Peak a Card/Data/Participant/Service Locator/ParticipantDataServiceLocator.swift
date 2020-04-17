import Foundation

class ParticipantDataServiceLocator: BaseDataServiceLocator {

    private lazy var repository: ParticipantsRepositoryProtocol = {
        return ParticipantsRepository(dataSource: ParticipantRemoteDataSource())
    }()

    func provideParticipantRepository() -> ParticipantsRepositoryProtocol {
        return repository
    }
}
