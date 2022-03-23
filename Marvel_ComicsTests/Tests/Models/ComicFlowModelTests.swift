//
//  Marvel_ComicsTests.swift
//  Marvel_ComicsTests
//
//  Created by Richardier on 21/03/2022.
//

import XCTest
@testable import Marvel_Comics

class ComicFlowModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var fakeComic: ComicResult!
    var model: ComicsFlowModel!
    var coordinatorMock: CoordinatorMock!
    
    //MARK: - setUp & tearDown methods

    override func setUpWithError() throws {
        super.setUp()
        fakeComic = FakeData.comics.first
        coordinatorMock = CoordinatorMock()
        model = ComicsFlowModel(coordinator: coordinatorMock)
    }

    override func tearDownWithError() throws {
        model = nil
    }
    
    // MARK: - Tests
    
    func testShowAllComicsScreen() {
        XCTAssertFalse(coordinatorMock.showAllComicsCalled)
        model.showAllComicsScreen()
        XCTAssertTrue(coordinatorMock.showAllComicsCalled)
    }
    
    func testShowComicDetailsScreen() {
        XCTAssertFalse(coordinatorMock.showComicDetailsCalled)
        model.showComicDetailsScreen(comic: fakeComic)
        XCTAssertTrue(coordinatorMock.showComicDetailsCalled)
    }
    
    func testShowFavoriteComics() {
        XCTAssertFalse(coordinatorMock.showFavoriteComicsCalled)
        model.showFavoriteComicsScreen()
        XCTAssertTrue(coordinatorMock.showFavoriteComicsCalled)
    }
}
