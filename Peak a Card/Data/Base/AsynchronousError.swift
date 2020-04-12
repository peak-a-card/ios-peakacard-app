import Foundation

enum AsynchronousError: Error {
    case parsing
    case itemNotFound
    case unknown(error: Error)

}
