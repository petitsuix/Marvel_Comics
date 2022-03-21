//
//  AppCoordinator.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("ok")
        showHomeScreen()
    }
    
    func showHomeScreen() {
        let homeViewController = HomeViewController()
        navigationController.pushViewController(homeViewController, animated: false)
    }
}
