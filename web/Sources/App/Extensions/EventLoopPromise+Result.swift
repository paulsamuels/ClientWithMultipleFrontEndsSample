import Shared
import Vapor

extension EventLoopPromise {
    /// Fulfil an `EventLoopPromise` with a `Result`
    ///
    /// The client uses callbacks with `Result` to handle asynchronous functions.
    /// The function performs the direct mapping of a results cases to a promise's cases.
    ///
    /// - Parameter result: The result used to fulfil the promise.
    func fulfil(_ result: Result<T>) {
        switch result {
        case .success(let value): succeed(result: value)
        case .failure(let error): fail(error: error)
        }
    }
}
