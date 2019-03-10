import Foundation
import Shared

_ = makeClient(debugEnabled: true).fetch { result in
    let encoded = result.flatMap { value -> Result<String> in
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            return .success(String(data: try encoder.encode(value), encoding: .utf8) ?? "")
        } catch {
            return .failure(error)
        }
    }
    
    switch encoded {
    case .success(let value):
        print(value)
        exit(EXIT_SUCCESS)
    case .failure(let error):
        print(error)
        exit(EXIT_FAILURE)
    }
}

dispatchMain()
