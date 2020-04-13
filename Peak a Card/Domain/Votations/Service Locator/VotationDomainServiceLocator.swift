import Foundation

class VotationDomainServiceLocator: BaseDomainServiceLocator {

    func provideGetAllVotationsUseCase() -> GetAllVotationsUseCase {
        return GetAllVotations(repository: root.data.votations.provideVotationsRepository())
    }
}
