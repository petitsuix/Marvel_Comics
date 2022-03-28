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
    let id: Int
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

extension ComicResult {
    init(from comicEntity: ComicsEntity) {
        self.id = Int(comicEntity.comicID)
        self.title = comicEntity.comicName ?? ""
        self.description = comicEntity.comicDescription
        if let coverData = comicEntity.comicCover, let coverImage = try? JSONDecoder().decode(Thumbnail.self, from: coverData) {
            self.thumbnail = coverImage
        } else {
            self.thumbnail = Thumbnail(path: "image_not_available", thumbnailExtension: "jpg")
        }
    }
}

//MARK: - Conformance

extension ComicResult: Equatable, Hashable {
    static func == (lhs: ComicResult, rhs: ComicResult) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {}
}
