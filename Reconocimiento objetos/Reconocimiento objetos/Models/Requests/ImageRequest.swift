//
//  ImageRequest.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 16/4/21.
//

import Foundation

struct ImageRequest: APIRequest {
    
    typealias Response = Data
    
    let imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    var method: Method = .GET
    
    var path: String {
        return imageUrl
    }
    
    var parameters: [String : String] = [:]
    
    var body: [String : Any] = [:]
    
    var headers: [String : String] = [:]
 
}
