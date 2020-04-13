import Foundation

class VotationDomainServiceLocator: BaseDomainServiceLocator {

    func provideGetAllVotationsUseCase() -> GetAllVotationsUseCase {
        return GetAllVotations(
            votationsRepository: root.data.votations.provideVotationsRepository(),
            participantsRepository: root.data.participants.provideParticipantRepository(),
            cardsRepository: root.data.cards.provideCardsRepository()
        )
    }

    func provideSubmitVotationUseCase() -> SubmitVotationUseCase {
        return SubmitVotation(repository: root.data.votations.provideVotationsRepository())
    }
}
