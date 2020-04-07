import Foundation

class SessionDomainServiceLocator: BaseDomainServiceLocator {

    func provideJoinSessionUseCase() -> JoinSessionUseCase {
        return JoinSession(repository: root.data.session.provideSessionRepository())
    }
}
