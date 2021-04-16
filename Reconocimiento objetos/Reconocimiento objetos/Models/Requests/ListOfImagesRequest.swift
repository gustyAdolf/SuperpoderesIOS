//
//  HundredImagesRequest.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 16/4/21.
//

import Foundation

struct ListOfImagesRequest: APIRequest {
    
    typealias Response = ListOfImages

    let amountOfImages: Int
    
    init(amountOfImages: Int) {
        self.amountOfImages = amountOfImages
    }
    
    var method: Method {
        .GET
    }
    
    var path: String {
        return "/v2/list"
    }
    
    var parameters: [String : String] {
        return [ "page" : "2", "limit" : String(amountOfImages)]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
        
    
}
