//
//  CatalogueCellViewModel.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import Foundation

protocol CatalogueCellViewDelegate: class {
    
}

class CatalogueCellViewModel {
    weak var viewDelegate: CatalogueCellViewDelegate?
    let imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
}
