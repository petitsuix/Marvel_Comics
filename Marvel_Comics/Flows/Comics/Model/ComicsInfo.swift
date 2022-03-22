//
//  Comic.swift
//  Marvel_Comics
//
//  Created by Richardier on 22/03/2022.
//

import Foundation

struct ComicsInfo: Codable {
    let data: Results
}

struct Results: Codable {
    let results: [ComicResult]
}

struct ComicResult: Codable {
    let title: String
    let description: String?
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

//extension ComicResult {
//    init(from recipeEntity: RecipesEntity) {
//        self.name = recipeEntity.name ?? ""
//        self.recipeUrl = recipeEntity.recipeUrl ?? ""
//        self.imageUrl = recipeEntity.imageUrl ?? ""
//        if let ingredientsData = recipeEntity.ingredients, let ingredients = try? JSONDecoder().decode([String].self, from: ingredientsData) {
//            self.ingredients = ingredients
//        } else {
//            self.ingredients = []
//        }
//        self.numberOfGuests = recipeEntity.numberOfGuests
//        self.totalTime = recipeEntity.totalTime
//    }
//}

extension ComicResult: Equatable, Hashable {
    static func == (lhs: ComicResult, rhs: ComicResult) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {}
}
