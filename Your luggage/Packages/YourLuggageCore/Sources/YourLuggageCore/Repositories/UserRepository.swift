//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 11/4/21.
//

import Foundation

public protocol UserRepositoryHolderProtocol {
    var userRepository: UserRepositoryProtocol { get set }
}

public protocol UserRepositoryProtocol {
    var isAuthorized: Bool { get }
    var userID: String? { get }
    var userName: String? { get }

    func signUp(
        with username: String,
        password: String,
        fullName: String,
        completion: @escaping (Result<String, AuthorizationError>) -> Void
    )
    
    func signIn(
        with username: String,
        password: String,
        completion: @escaping (Result<String, AuthorizationError>) -> Void
    )

    func saveUser(with userID: String)
}

public class UserRepository: UserRepositoryProtocol {
    public var isAuthorized: Bool {
        userID != nil
    }
    
    public var userID: String? {
        secureUserStorage.loadUser().map { String(decoding: $0, as: UTF8.self) }
    }
    
    public var userName: String? {
        guard let userID = userID else { return "User"}
        return secureUserStorage.loadUserName(using: userID).map { String(decoding: $0, as: UTF8.self) }
    }
    
    let api: AuthorizationAPI
    let secureUserStorage: SecureUserStorageProtocol
    let userStorage: UserStorageProtocol
    
    public init(
        api: AuthorizationAPI,
        secureUserStorage: SecureUserStorageProtocol,
        userStorage: UserStorageProtocol
    ) {
        self.api = api
        self.secureUserStorage = secureUserStorage
        self.userStorage = userStorage
    }
    
    public func signUp(
        with username: String,
        password: String,
        fullName: String,
        completion: @escaping (Result<String, AuthorizationError>) -> Void
    ) {
        api.signUp(
            using: .init(authType: .email(username, password, fullName)),
            complition: { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)

                case .success(let userID):
                    self?.secureUserStorage.save(userID: userID)
                    self?.secureUserStorage.save(userName: fullName, key: userID)
                    completion(.success(userID))
                }
            }
        )
    }
    
    public func signIn(
        with username: String,
        password: String,
        completion: @escaping (Result<String, AuthorizationError>) -> Void
    ) {
        api.signIn(
            using: .init(authType: .email(username, password, password)),
            complition: { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)

                case .success(let userID):
                    self?.secureUserStorage.save(userID: userID)
                    completion(.success(userID))
                }
            }
        )
    }

    public func saveUser(with userID: String) {
        userStorage.saveUser(with: userID)
    }
    
    public func fetchUserName(using userID: String) -> String {
        api.fetchUserName(using: userID)
    }
}

public struct UserRepositoryMock: UserRepositoryProtocol {
    public func saveUser(with userID: String) {
        //
    }

    public var coreDataStorage: TripStorageProtocol
    
    
    public func fetchUserName(using userID: String) -> String {
        return ""
    }
    
    public var userID: String?
    
    public var userName: String?
    
    public var isAuthorized: Bool = true
    
    public func signUp(with username: String, password: String, fullName: String, completion: @escaping (Result<String, AuthorizationError>) -> Void) {
        
    }
    
    public func signIn(with username: String, password: String, completion: @escaping (Result<String, AuthorizationError>) -> Void) {
        
    }
    
    public init() {
        coreDataStorage = Storage()
    }
}
