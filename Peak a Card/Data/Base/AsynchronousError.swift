import Foundation

enum AsynchronousError: Error {
    case parsing
    case sessionNotFound
    case unknown(error: Error)
}
