//
//  SceneDelegate.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 05.03.2023.
//

import FBSDKCoreKit
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard UserDefaults.standard.string(forKey: UserDefaultsKeys.loggedInUserEmail.rawValue) != nil else { return }
        let storyboard = UIStoryboard (name: Storyboards.tabBar.rawValue, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllers.tabBar.rawValue) as! UITabBarController

        let navVC = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
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

      //  (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let openURLContext = Array(URLContexts).first
        if openURLContext != nil {
            if let URL = openURLContext?.url, let annotation = openURLContext?.options.annotation {
                ApplicationDelegate.shared.application(UIApplication.shared, open: URL, sourceApplication: openURLContext?.options.sourceApplication, annotation: annotation)
            }
        }
    }
}

