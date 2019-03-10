import Foundation

public protocol JSONPlaceholderClient {
    /// Represents a function to invoke to cancel a request.
    typealias Cancellation = () -> Void
    
    /// Fetch a list of people from jsonplaceholder.typicode.com.
    ///
    /// - Parameter completion: A completion handler to call with results.
    /// - Returns: A function that can be invoked to cancel the network request.
    func fetch(completion: @escaping (Result<Decoded<[Person]>>) -> Void) -> Cancellation
}

/// Create a JSONPlaceholderClient with the passed debug status.
///
/// - Parameter debugEnabled: Whether the client should be created in debug mode or not.
///
///   When `debugEnabled = true` a successful `Result` will return the `.debug` case.
///
///   When `debugEnabled = false` a successful `Result` will return the `.prod` case.
/// - Returns: A client.
public func makeClient(debugEnabled: Bool = false) -> JSONPlaceholderClient {
    return ConcreteJSONPlaceholderClient(debugEnabled: debugEnabled)
}

final class ConcreteJSONPlaceholderClient: JSONPlaceholderClient {
    private let debugEnabled: Bool
    
    init(debugEnabled: Bool) {
        self.debugEnabled = debugEnabled
    }
    
    func fetch(completion: @escaping (Result<Decoded<[Person]>>) -> Void) -> Cancellation {
        let debugEnabled = self.debugEnabled
        
        let task = URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/users")!) { data, response, error in
            guard let data = data, data.count > 0 else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.debugContextEnabled = debugEnabled
                let results = try decoder.decode(Decoded<[FailableDecodable<Person>]>.self, from: data).map {
                    $0.compactMap { $0.base }
                }
                
                completion(.success(results))
            } catch {
                
            }
        }
        
        task.resume()
        
        return task.cancel
    }
}
