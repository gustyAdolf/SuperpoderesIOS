//
//  ClientDataManager.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 16/4/21.
//

import Foundation

class ClientDataManager {
    let remoteDataManager: RemoteDataManager
    
    init(remoteDataManager: RemoteDataManager) {
        self.remoteDataManager = remoteDataManager
    }
}

extension ClientDataManager: CatalogueDataManager {
    func fetchListOfImages(amountOfImages: Int, completion: @escaping (Result<ListOfImages?, Error>) -> ()) {
        remoteDataManager.fetchListOfImages(amountOfImages: amountOfImages, completion: completion)
    }
    
    func fetchImageData(imageUrl: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        remoteDataManager.fetchImageData(imageUrl: imageUrl, completion: completion)
    }
    
    
}
