import AnyCodable
import Foundation

/// A wrapper that can optionally contain decoded items of the generic type
/// or decoded items of the generic type, the Raw input data and any errors
/// generated during processing.
public enum Decoded<T: Decodable>: Decodable {
    case debug(value: T, raw: AnyCodable, errors: [Error])
    case prod(value: T)
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(T.self)
        
        if decoder.debugContextEnabled {
            let errors = decoder.debugContext?.errors
            let raw    = try decoder.singleValueContainer().decode(AnyCodable.self)
            
            self = .debug(value: value, raw: raw, errors: errors ?? [])
        } else {
            self = .prod(value: value)
        }
    }
    
    /// Returns a new Decoded containing the result of invoking the given closure on the current value.
    ///
    /// - Parameter transform: A mapping closure.
    /// - Returns: A new Decoded with the newly mapped type.
    func map<B>(_ transform: (T) -> B) -> Decoded<B> {
        switch self {
        case let .debug(value: value, raw: raw, errors: errors):
            return .debug(value: transform(value), raw: raw, errors: errors)
        case .prod(value: let value):
            return .prod(value: transform(value))
        }
    }
}

extension Decoded: Encodable where T: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case let .debug(value: value, raw: raw, errors: errors):
            try container.encode(value, forKey: .value)
            try container.encode(raw, forKey: .raw)
            try container.encode(errors.map { $0.localizedDescription }, forKey: .errors)
        case let .prod(value: value):
            try container.encode(value, forKey: .value)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case value
        case raw
        case errors
    }
}
