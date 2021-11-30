import Foundation

public struct AuthParameters: Encodable {
    public enum AuthType: Encodable {
        public func encode(to encoder: Encoder) throws {
            
        }
        
        case email(_ username: String, _ password: String, _ fullName: String)
        case apple(_ id: String)
    }

    public let authType: AuthType

    public init(authType: AuthType) {
        self.authType = authType
    }
}
