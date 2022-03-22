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
        showHomeScreen()
    }
    
    func showHomeScreen() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func showAllComicsScreen() {
        let allComicsViewController = ComicsListViewController()
        allComicsViewController.dataMode = .api
        allComicsViewController.coordinator = self
        navigationController.pushViewController(allComicsViewController, animated: true)
    }
    
    func showFavoriteComicsScreen() {
        let favoriteComicsViewController = ComicsListViewController()
        favoriteComicsViewController.dataMode = .coreData
        navigationController.pushViewController(favoriteComicsViewController, animated: true)
    }
    
    func showComicDetailsScreen(comic: ComicResult) {
        let comicDetailsViewController = ComicDetailsViewController()
        comicDetailsViewController.comic = comic
        navigationController.pushViewController(comicDetailsViewController, animated: true)
    }
}
