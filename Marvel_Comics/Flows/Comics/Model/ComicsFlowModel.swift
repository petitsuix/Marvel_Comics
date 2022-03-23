//
//  Model.swift
//  Marvel_Comics
//
//  Created by Richardier on 23/03/2022.
//

class ComicsFlowModel {
    
    private let coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
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
