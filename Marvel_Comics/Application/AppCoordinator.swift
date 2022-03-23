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
    var storageService: StorageService
    
    init(navigationController: UINavigationController, storageService: StorageService) {
        self.navigationController = navigationController
        self.storageService = storageService
    }
    
    func start() {
        showHomeScreen()
    }
    
    func showHomeScreen() {
        let homeViewController = HomeViewController()
        homeViewController.model = ComicsFlowModel(coordinator: self, storageService: storageService)
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func showAllComicsScreen() {
        let allComicsViewController = ComicsListViewController()
        allComicsViewController.model = ComicsFlowModel(coordinator: self, storageService: storageService)
        allComicsViewController.dataMode = .api
        navigationController.pushViewController(allComicsViewController, animated: true)
    }
    
    func showFavoriteComicsScreen() {
        let favoriteComicsViewController = ComicsListViewController()
        favoriteComicsViewController.model = ComicsFlowModel(coordinator: self, storageService: storageService)
        favoriteComicsViewController.dataMode = .coreData
        navigationController.pushViewController(favoriteComicsViewController, animated: true)
    }
    
    func showComicDetailsScreen(comic: ComicResult) {
        let comicDetailsViewController = ComicDetailsViewController()
        comicDetailsViewController.comic = comic
        navigationController.pushViewController(comicDetailsViewController, animated: true)
    }
}
