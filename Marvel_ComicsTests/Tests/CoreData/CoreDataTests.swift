//
//  CoreDataTests.swift
//  Marvel_ComicsTests
//
//  Created by Richardier on 23/03/2022.
//

import CoreData
import XCTest
@testable import Marvel_Comics

class CoreDataTests: XCTestCase {
    
    // MARK: - Properties
    
    var storageService: StorageService!
    var loadedComics: [ComicResult] = []
    
    var comic1 = FakeData.comics.first!
    var comic2 = FakeData.comics[1]
    
    // MARK: - setUp & tearDown Methods
    
    override func setUp() {
        super.setUp()
        loadedComics = [comic1, comic2]
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        persistentStoreDescription.shouldAddStoreAsynchronously = true
       
        let persistentContainer = NSPersistentContainer(name: "Marvel_Comics",
                                                        managedObjectModel: managedObjectModel)
        persistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        persistentContainer.loadPersistentStores { description, error in
            precondition(description.type == NSInMemoryStoreType, "Store description is not of type NSInMemoryStoreType")
            if let error = error as NSError? {
                fatalError("Persistent container creation failed : \(error.userInfo)")
            }
        }
        storageService = StorageService(persistentContainer: persistentContainer)
    }
    
    override func tearDown() {
        super.tearDown()
        storageService = nil
        loadedComics = []
    }
    
    // MARK: - Tests
    
    func testComicLoading() throws {
        var loadedComics: [ComicResult] = []
        
        let comic = FakeData.comics.first!
        
        do {
            try storageService.saveComic(comic)
        } catch {
            XCTFail("error saving \(error.localizedDescription)")
        }
        
        do {
            loadedComics = try storageService.loadComics()
        } catch {
            XCTFail("error saving \(error.localizedDescription)")
        }
        XCTAssertFalse(loadedComics.isEmpty)
    }
    
    func testDeletingComic() {
        for comic in loadedComics {
            do {
                try storageService.saveComic(comic)
            } catch {
                XCTFail("error saving \(error.localizedDescription)")
            }
            
            do {
                try storageService.deleteComic(comic)
            } catch {
                XCTFail("error deleting \(error.localizedDescription)")
            }
            
            do {
                loadedComics = try storageService.loadComics()
            } catch {
                XCTFail("error loading \(error.localizedDescription)")
            }
        }
        XCTAssertTrue(loadedComics.isEmpty)
        XCTAssert(loadedComics.count == 0)
    }
}
