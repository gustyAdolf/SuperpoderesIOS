//
//  CatalogueDataManager.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 16/4/21.
//

import Foundation

protocol CatalogueDataManager {
    func fetchListOfImages(amountOfImages: Int, completion: @escaping (Result<ListOfImages?, Error>) -> ())
    func fetchImageData(imageUrl: String, completion: @escaping (Result<Data?, Error>) -> ())
}
