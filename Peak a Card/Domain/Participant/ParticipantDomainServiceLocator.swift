import Foundation

class ParticipantDomainServiceLocator: BaseDomainServiceLocator {

    func provideGetAllParticipantsUseCase() -> GetAllParticipantsUseCase {
        return GetAllParticipants(repository: root.data.participants.provideParticipantRepository())
    }

    func provideRemoveParticipantUseCase() -> RemoveParticipantUseCase {
        return RemoveParticipant(repository: root.data.participants.provideParticipantRepository())
    }
}
