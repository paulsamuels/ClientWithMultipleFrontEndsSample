import Foundation

public struct FailableDecodable<Base: Decodable>: Decodable {
    public let base: Base?
    
    public init(from decoder: Decoder) throws {
        do {
            base = try decoder.singleValueContainer().decode(Base.self)
        } catch {
            decoder.debugContext?.errors.append(error)
            base = nil
        }
    }
}
