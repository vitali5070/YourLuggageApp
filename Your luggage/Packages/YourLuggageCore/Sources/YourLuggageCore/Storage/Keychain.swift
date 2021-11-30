//
//  File.swift
//
//
//  Created by Vitaly Nabarouski on 8.11.21.
//

import Foundation
import Security
import SwiftUI

public protocol SecureUserStorageProtocol {
    func save(userID: String)
    func save(userName: String, key: String)
    func loadUser() -> Data?
    func loadUserName(using userId: String) -> Data?
}

public final class Keychain: SecureUserStorageProtocol {
    private enum KeyConstant {
        static let userID = "UserID"
    }
    
    public init() { }

    public func save(userID: String) {
        let data = userID.data(using: .utf8)
        save(data: data, key: KeyConstant.userID)
    }

    public func save(userName: String, key: String) {
        let data = userName.data(using: .utf8)
        save(data: data, key: key)
    }

    // TODO: DRY
    private func save(data: Data?, key: String) {
        guard let data = data else {
            return
        }

        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data] as [String : Any]

        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)
        print("Save data for key \(key). Status: \(status)")
    }
    
    public func loadUser() -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : KeyConstant.userID,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
                
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    public func loadUserName(using userId: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : userId,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
                
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
}
