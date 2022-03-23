//
//  fakeData.swift
//  Marvel_ComicsTests
//
//  Created by Richardier on 23/03/2022.
//

import CoreData
import Foundation
@testable import Marvel_Comics

final class FakeData {
    
    class FakeError: Error {}
    static let error = FakeError()
    
    //static let viewContext: NSManagedObjectContext? = nil
    
    static var comics: [ComicResult] {
        let comicInfo = try! JSONDecoder().decode(ComicsInfo.self, from: comicData)
        return comicInfo.data.results
    }
    
    static var comicData: Data {
        let bundle = Bundle(for: FakeData.self)
        let url = bundle.url(forResource: "Marvel", withExtension: "json")
        return try! Data(contentsOf: url!)
    }
    static let incorrectData = "erreur".data(using: .utf8)!
}
