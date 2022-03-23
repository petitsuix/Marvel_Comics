//
//  AppCoordinatorProtocol.swift
//  Marvel_Comics
//
//  Created by Richardier on 23/03/2022.
//

import Foundation

protocol AppCoordinatorProtocol: Coordinator {
    func showAllComicsScreen()
    func showFavoriteComicsScreen()
    func showComicDetailsScreen(comic: ComicResult)
}
