//
//  Model.swift
//  Marvel_Comics
//
//  Created by Richardier on 23/03/2022.
//

class ComicsFlowModel {
    
    private let coordinator: AppCoordinator
    private let storageService: StorageService
    
    init(coordinator: AppCoordinator, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    func showAllComicsScreen() {
        coordinator.showAllComicsScreen()
    }
    
    func showFavoriteComicsScreen() {
        coordinator.showFavoriteComicsScreen()
    }
    
    func showComicDetailsScreen(comic: ComicResult) {
        coordinator.showComicDetailsScreen(comic: comic)
    }
}
