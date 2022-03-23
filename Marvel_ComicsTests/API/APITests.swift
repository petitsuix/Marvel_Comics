//
//  APITests.swift
//  Marvel_ComicsTests
//
//  Created by Richardier on 23/03/2022.
//

import XCTest

@testable import Marvel_Comics
@testable import Alamofire

class APITests: XCTestCase {

    // MARK: - Properties
    
    var session: Session!
    var networkService: NetworkService!
    
    // MARK: - setUp & tearDown Methods
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolMock.self]
        session = Session(configuration: configuration)
        networkService = NetworkService(session: session)
    }
    
    override func tearDownWithError() throws {
        UrlProtocolMock.data = nil
        UrlProtocolMock.error = nil
    }
    
    // MARK: - Tests
    
    func testGetComicsShouldPostFailedCompletionIfError() throws {
        let expectation = XCTestExpectation(description: "get comics") // Purpose is being able to wait for the request, operated asynchronously. Otherwise, the end of the test is read immediately without going through the completion.
        // Given :
        UrlProtocolMock.error = AFError.explicitlyCancelled
        // When :
        networkService.fetchData() { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Missing failure error")
                return
            }
            // Then :
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetRecipesShouldWork() throws {
        let expectation = XCTestExpectation(description: "get recipes")
        // Given :
        UrlProtocolMock.data = FakeData.comicData
        // When :
        networkService.fetchData() { (result) in
            // Then :
            guard case .success(let comics) = result else {
                XCTFail("Missing success data")
                return
            }
            XCTAssertNotNil(comics)
            let comic = try! XCTUnwrap(comics.data.results.first, "missing comic")
            XCTAssertEqual(comic.title, "Marvel Previews (2017)")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
