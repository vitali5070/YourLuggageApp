import Foundation
import FirebaseAuth
import FirebaseDatabase

public protocol AuthorizationAPI {
    func signIn(using parameters: AuthParameters, complition: @escaping (Result<String, Error>) -> Void)
    func signUp(using parameters: AuthParameters, complition: @escaping (Result<String, Error>) -> Void)
    func fetchUserName(using userID: String) -> String
}

extension APIClient: AuthorizationAPI {
    
    public func signIn(using parameters: AuthParameters, complition: @escaping (Result<String, Error>) -> Void) {
        switch parameters.authType {
        case .apple( _):
            break
        case .email(let email, let password, _):
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                guard let result = result, error == nil else { return }
                complition(.success(result.user.uid))
            }
        }
    }
    
    public func signUp(using parameters: AuthParameters, complition: @escaping (Result<String, Error>) -> Void) {
        switch parameters.authType {
        case .email(let email, let password, let fullName):
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                guard let result = result, error == nil else { return }
                let reference = Database.database().reference().child("users")
                reference.child(result.user.uid).updateChildValues(["fullName" : fullName, "email" : email])
                complition(.success(result.user.uid))
            }
        case .apple( _):
            break
        }
    }
    
    public func fetchUserName(using userID: String) -> String {
        let reference = Database.database().reference().child("users")
        var userName: String = ""
        reference.child(userID).child("fullName").getData { (error, userNameData) in
            guard error == nil else { return }
            userName = userNameData.value as? String ?? "User"
            print("UserName in fetchUserName func: \(userName)")
        }
        return userName
    }
}
