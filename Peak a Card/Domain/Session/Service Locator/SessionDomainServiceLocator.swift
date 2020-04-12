import Foundation

class SessionDomainServiceLocator: BaseDomainServiceLocator {

    func provideJoinSessionUseCase() -> JoinSessionUseCase {
        return JoinSession(repository: root.data.session.provideSessionRepository())
    }

    func provideVerifySessionUseCase() -> VerifySessionUseCase {
        return VerifySession(repository: root.data.session.provideSessionRepository())
    }
}
