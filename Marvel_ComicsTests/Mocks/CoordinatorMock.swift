//
//  CoordinatorMock.swift
//  Marvel_ComicsTests
//
//  Created by Richardier on 23/03/2022.
//

import Foundation
import UIKit
@testable import Marvel_Comics

class CoordinatorMock: AppCoordinatorProtocol {
    
    var navigationController = UINavigationController()
    
    var comic: ComicResult?
    
    var coordinatorStartCalled = false
    func start() {
        coordinatorStartCalled = true
    }
    
    var showAllComicsCalled = false
    func showAllComicsScreen() {
        showAllComicsCalled = true
    }
    
    var showFavoriteComicsCalled = false
    func showFavoriteComicsScreen() {
        showFavoriteComicsCalled = true
    }
    
    var showComicDetailsCalled = false
    func showComicDetailsScreen(comic: ComicResult) {
        showComicDetailsCalled = true
    }
}
