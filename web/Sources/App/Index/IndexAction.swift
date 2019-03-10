import HtmlVaporSupport
import Shared
import Vapor

enum Index {
    /// This action uses the Networking client in debug mode to fetch people from
    /// https://jsonplaceholder.typicode.com/users.
    ///
    /// The resulting page shows:
    /// - Any errors that were generated when parsing the JSON data.
    /// - The raw unfiltered JSON.
    /// - The processed data as seen by the iOS application.
    ///
    /// - Parameter request: The request caused this function's invocation.
    /// - Returns: A future Node that can be used to render a web page.
    static func action(_ request: Request) -> Future<Node> {
        let promise = request.eventLoop.newPromise(Node.self)
        
        _ = makeClient(debugEnabled: true).fetch { result in
            promise.fulfil(result.flatMap(prepare).map(render))
        }
        
        return promise.futureResult
    }
}
