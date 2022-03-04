//
//  SceneDelegate.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController()
        let vc = SeriesListFactory.makeController(navigationController: navController)
        navController.setViewControllers([vc], animated: false)
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}

