import Foundation

class DecoderDebugContext {
    var errors = [Error]()
}

private let decoderDebugContextKey = CodingUserInfoKey(rawValue: "com.paul-samuels.decoder-debug-context")!

extension JSONDecoder {
    var debugContext: DecoderDebugContext? {
        return userInfo[decoderDebugContextKey] as? DecoderDebugContext
    }
    
    var debugContextEnabled: Bool {
        get { return debugContext != nil }
        set {
            if newValue {
                userInfo[decoderDebugContextKey] = debugContext ?? DecoderDebugContext()
            } else {
                userInfo[decoderDebugContextKey] = nil
            }
        }
    }
}

extension Decoder {
    var debugContext: DecoderDebugContext? {
        return userInfo[decoderDebugContextKey] as? DecoderDebugContext
    }
    
    var debugContextEnabled: Bool {
        return debugContext != nil
    }
}
