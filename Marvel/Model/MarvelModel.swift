//
//  MarvelList.swift
//  Marvel
//
//  Created by Naveen Kumar on 22/02/22.
//

import Foundation

struct Marvel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name, description: String
    let thumbnail: Thumbnail
    let comics, series: Comics
}

// MARK: - Comics
struct Comics: Codable {
    let items: [ComicsItem]
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let name: String
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}
