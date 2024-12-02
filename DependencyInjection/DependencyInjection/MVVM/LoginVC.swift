//
//  LoginVC.swift
//  DependencyInjection
//
//  Created by Kavya Krishna K. on 02/12/24.
//

import UIKit

protocol UserDataManagerProtocol {
    func saveUser(userName: String, userId: String)
}

class LoginVC: UIViewController {
    private let userDataManager: UserDataManagerProtocol
    
    // Inject dependency via initializer
    init(userDataManager: UserDataManagerProtocol) {
        self.userDataManager = userDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Save data
        loginSuccessful(userName: "john.doe", userId: "123456")

        //Retrieve data
        let credentials = fetchUserCredentials()
        if let userName = credentials.userName, let userId = credentials.userId {
            print("Username: \(userName), UserId: \(userId)")
        } else {
            print("No credentials found.")
        }

    }
    
    func loginSuccessful(userName: String, userId: String) {
        // Use the injected dependency to save data via UserDataManager
        userDataManager.saveUser(userName: userName, userId: userId)
        
        // Save username in Keychain
        let userNameKey = "userName"
        if let usernameData = userName.data(using: .utf8) {
            let saveUserNameStatus = Keychain.save(key: userNameKey, data: usernameData)
            if saveUserNameStatus == errSecSuccess {
                print("Username saved successfully.")
            } else {
                print("Failed to save username: \(saveUserNameStatus)")
            }
        } else {
            print("Failed to encode username to Data.")
        }
        
        // Save userId in Keychain
        let userIdKey = "userId"
        if let userIdData = userId.data(using: .utf8) {
            let saveUserIdStatus = Keychain.save(key: userIdKey, data: userIdData)
            if saveUserIdStatus == errSecSuccess {
                print("UserId saved successfully.")
            } else {
                print("Failed to save userId: \(saveUserIdStatus)")
            }
        } else {
            print("Failed to encode userId to Data.")
        }
    }
    
    func fetchUserCredentials() -> (userName: String?, userId: String?) {
        // Retrieve username from Keychain
        let userNameKey = "userName"
        let userNameData = Keychain.load(key: userNameKey)
        let userName = userNameData != nil ? String(data: userNameData!, encoding: .utf8) : nil
        
        // Retrieve userId from Keychain
        let userIdKey = "userId"
        let userIdData = Keychain.load(key: userIdKey)
        let userId = userIdData != nil ? String(data: userIdData!, encoding: .utf8) : nil
        
        return (userName, userId)
    }


}


class MockUserDataManager: UserDataManagerProtocol {
    var saveUserCalled = false
    
    func saveUser(userName: String, userId: String) {
        saveUserCalled = true
        print("Mock saveUser called with \(userName), \(userId)")
    }
}

// Unit Test
func testLoginSuccessful() {
    let mockManager = MockUserDataManager()
    let loginVC = LoginVC(userDataManager: mockManager)
    
    loginVC.loginSuccessful(userName: "TestUser", userId: "TestID")
    
    assert(mockManager.saveUserCalled, "saveUser should be called")
}
