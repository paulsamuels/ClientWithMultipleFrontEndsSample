import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
    
    public func map<NewValue>(_ transform: (Value) -> NewValue) -> Result<NewValue> {
        switch self {
        case .success(let value):
            return .success(transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func flatMap<NewValue>(_ transform: (Value) -> Result<NewValue>) -> Result<NewValue> {
        switch self {
        case .success(let value):
            return transform(value)
        case .failure(let error):
            return .failure(error)
        }
    }
}
