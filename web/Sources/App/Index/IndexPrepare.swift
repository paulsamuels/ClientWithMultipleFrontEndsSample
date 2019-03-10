import HtmlVaporSupport
import Shared
import Vapor

extension Index {
    /// Plain Old Swift Type that represents the prepared data to be rendered.
    struct Result {
        /// A pretty printed JSON representation of the data parsed into the
        /// app's domain models.
        let decoded: String
        
        /// Any errors generated whilst the app code was parsing the input JSON.
        let errors: [String]
        
        /// The raw JSON representation before any processing has occured.
        let raw: String
    }
    
    /// Prepares the data to be rendered.
    /// The data is not in the easiest format to render so this function extracts each value,
    /// creates a pretty printed version and then bundles them all together in an `Index.Result`.
    ///
    /// - Parameter value: The value to process.
    /// - Returns: A new `Result` that contains a simpler representation of the data.
    static func prepare(_ value: Decoded<[Person]>) -> Shared.Result<Index.Result> {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        switch value {
        case let .debug(value: value, raw: raw, errors: errors):
            do {
                return .success(
                    .init(
                        decoded: String(data: try encoder.encode(value), encoding: .utf8) ?? "",
                        errors: errors.map { $0.localizedDescription },
                        raw: String(data: try encoder.encode(raw), encoding: .utf8) ?? ""
                    )
                )
            } catch {
                return .failure(error)
            }
            
        default:
            return .failure(Abort(.internalServerError, reason: "Client not in debug mode"))
        }
    }
}
