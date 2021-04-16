//
//  ClientDataManagerIml.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 16/4/21.
//

import Foundation

class RemoteDataManagerIml: RemoteDataManager {
    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }
    
    func fetchListOfImages(amountOfImages: Int, completion: @escaping (Result<ListOfImages?, Error>) -> ()) {
        let request = ListOfImagesRequest(amountOfImages: amountOfImages)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchImageData(imageUrl: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        let request = ImageRequest(imageUrl: imageUrl).requestWithOutBaseUrl()
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, repsonse, error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                completion(.success(data))
            }        }
        task.resume()
    }
    
   
    
    
    
    
}
