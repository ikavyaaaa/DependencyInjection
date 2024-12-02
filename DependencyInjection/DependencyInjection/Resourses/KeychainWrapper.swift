//
//  KeychainWrapper.swift
//  DependencyInjection
//
//  Created by Kavya Krishna K. on 02/12/24.
//

import Foundation

final class Keychain {
    
    /// Save data to Keychain
    /// - Parameters:
    ///   - key: The key to identify the stored data.
    ///   - data: The data to be stored in the Keychain.
    /// - Returns: Status of the Keychain operation.
    @discardableResult
    class func save(key: String, data: Data) -> OSStatus {
        // Keychain query to add or update data
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // Delete any existing item with the same key
        SecItemDelete(query as CFDictionary)
        
        // Add the new data to the Keychain
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    /// Load data from Keychain
    /// - Parameter key: The key to identify the stored data.
    /// - Returns: The retrieved data, or `nil` if not found.
    class func load(key: String) -> Data? {
        // Keychain query to fetch the data
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        
        // Attempt to retrieve the data
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as? Data
        } else {
            return nil
        }
    }
    
    /// Delete data from Keychain
    /// - Parameter key: The key to identify the data to be deleted.
    /// - Returns: Status of the Keychain operation.
    @discardableResult
    class func delete(key: String) -> OSStatus {
        // Keychain query to delete the data
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
    
    /// Generate a unique identifier (UUID)
    /// - Returns: A string representation of a UUID.
    class func createUniqueID() -> String {
        return UUID().uuidString
    }
}
