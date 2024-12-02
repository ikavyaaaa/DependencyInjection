//
//  SceneDelegate.swift
//  DependencyInjection
//
//  Created by Kavya Krishna K. on 02/12/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create the shared instance of UserDataManager
        let userDataManager = UserDataManager()
        
        // Inject the dependency
        let loginVC = LoginVC(userDataManager: userDataManager)
        
        // Set up the window
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = loginVC
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    
}

