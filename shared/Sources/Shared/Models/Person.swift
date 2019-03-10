import Foundation

/// A representation of a `Person`
///
/// For the sake of making this example a little more useful there is some
/// arbitrary validation that checks that a website must have a suffix of "com".
public struct Person: Codable {
    public let id: Int
    public let name: String
    public let website: URL
    
    public init(id: Int, name: String, website: URL) {
        self.id      = id
        self.name    = name
        self.website = website
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id      = try container.decode(Int.self, forKey: .id)
        self.name    = try container.decode(String.self, forKey: .name)
        self.website = try container.decode(URL.self, forKey: .website)
        
        if !website.path.hasSuffix("com") {
            throw OnlySupportsDotCom(actual: website, at: decoder.codingPath)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(website, forKey: .website)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case website
    }
}

public struct OnlySupportsDotCom: LocalizedError {
    let actual: URL
    let codingPath: [CodingKey]
    
    init(actual: URL, at codingPath: [CodingKey]) {
        self.actual     = actual
        self.codingPath = codingPath
    }
    
    public var errorDescription: String? {
        return "Invalid website '\(actual)' found at \(codingPath)."
    }
}
