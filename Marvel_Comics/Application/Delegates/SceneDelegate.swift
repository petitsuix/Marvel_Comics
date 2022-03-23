//
//  SceneDelegate.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window else { return }
        let navigationController = UINavigationController()
        coordinator = AppCoordinator(navigationController: navigationController, storageService: StorageService())
        coordinator?.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

