import Foundation

public enum AuthorizationError: Error {
    case invalidCredentials
}

public protocol AuthorizationServiceHolderProtocol {
    var authorizationService: AuthorizationServiceProtocol { get }
}

public protocol AuthorizationServiceProtocol {
    func authorizeWith(username: String, password: String, completion: @escaping (Result<Void, AuthorizationError>) -> Void)
}

public class AuthorizationService: AuthorizationServiceProtocol {

    public init() { }

    public func authorizeWith(username: String, password: String, completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            if username == "user", password == "some_password" {
                completion(Result.success(()))
            } else {
                completion(Result.failure(AuthorizationError.invalidCredentials))
            }
        }
    }
}
