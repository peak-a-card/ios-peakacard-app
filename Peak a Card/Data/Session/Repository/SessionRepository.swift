import Foundation
import Combine

protocol SessionRepositoryProtocol {
    func join(code: String, user: UserDomainModel) -> AnyPublisher<Void, AsynchronousError>
    func verify(code: String) -> AnyPublisher<String, AsynchronousError>
}

class SessionRepository: SessionRepositoryProtocol {

    private let dataSource: SessionRemoteDataSource

    init(dataSource: SessionRemoteDataSource) {
        self.dataSource = dataSource
    }

    func join(code: String, user: UserDomainModel) -> AnyPublisher<Void, AsynchronousError> {
        let userDataModel = UserDataModel(id: user.id, information: UserInformationDataModel(name: user.name, email: user.email))
        return dataSource.join(code: code, user: userDataModel)
    }

    func verify(code: String) -> AnyPublisher<String, AsynchronousError> {
        return dataSource.verify(code: code)
    }
}
