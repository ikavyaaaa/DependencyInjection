//
//  UserDataManager.swift
//  DependencyInjection
//
//  Created by Kavya Krishna K. on 02/12/24.
//

import Foundation


class UserDataManager: UserDataManagerProtocol {
    func saveUser(userName: String, userId: String) {
        let defaults = UserDefaults.standard
        defaults.set(userName, forKey: "userName")
        defaults.set(userId, forKey: "userId")
        print("User saved in UserDefaults: \(userName), ID: \(userId)")
    }
    
    func getUser() -> (userName: String?, userId: String?) {
        let defaults = UserDefaults.standard
        let userName = defaults.string(forKey: "userName")
        let userId = defaults.string(forKey: "userId")
        return (userName, userId)
    }
}

/*
let userDataManager = UserDataManager()
userDataManager.saveUser(userName: "John", userId: "1234")

let user = userDataManager.getUser()
print("Retrieved User: \(user.userName ?? ""), ID: \(user.userId ?? "")")

*/


//MARK: - Keychain

//import KeychainWrapper
//
//class UserDataManager: UserDataManagerProtocol {
//    func saveUser(userName: String, userId: String) {
//        let keychain = KeychainWrapper.standard
//        keychain.set(userName, forKey: "userName")
//        keychain.set(userId, forKey: "userId")
//        print("User saved in Keychain: \(userName), ID: \(userId)")
//    }
//    
//    func getUser() -> (userName: String?, userId: String?) {
//        let keychain = KeychainWrapper.standard
//        let userName = keychain.string(forKey: "userName")
//        let userId = keychain.string(forKey: "userId")
//        return (userName, userId)
//    }
//}
//
//let userDataManager = UserDataManager()
//userDataManager.saveUser(userName: "John", userId: "1234")
//
//let user = userDataManager.getUser()
//print("Retrieved User from Keychain: \(user.userName ?? ""), ID: \(user.userId ?? "")")


//MARK: - CoreData

//import CoreData
//
//class UserDataManager: UserDataManagerProtocol {
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    
//    func saveUser(userName: String, userId: String) {
//        let user = User(context: context)
//        user.userName = userName
//        user.userId = userId
//        
//        do {
//            try context.save()
//            print("User saved in Core Data: \(userName), ID: \(userId)")
//        } catch {
//            print("Failed to save user: \(error.localizedDescription)")
//        }
//    }
//    
//    func getUser() -> User? {
//        let request: NSFetchRequest<User> = User.fetchRequest()
//        
//        do {
//            let users = try context.fetch(request)
//            return users.first
//        } catch {
//            print("Failed to fetch user: \(error.localizedDescription)")
//            return nil
//        }
//    }
//}
//
//let userDataManager = UserDataManager()
//userDataManager.saveUser(userName: "John", userId: "1234")
//
//if let user = userDataManager.getUser() {
//    print("Retrieved User from Core Data: \(user.userName ?? ""), ID: \(user.userId ?? "")")
//}
