//
//  HundredImagesResponse.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 16/4/21.
//

import Foundation

// MARK: - ListOfImagesResponse

typealias ListOfImages = [ImageItem]

struct ImageItem: Codable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
