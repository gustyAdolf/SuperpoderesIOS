//
//  SearchViewModel.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import Foundation

protocol SearchCoordinatorDelegate: class {
    
}

protocol SearchViewDelegate: class {
    
}

class SearchViewModel {
    weak var coordinateDelegate: SearchCoordinatorDelegate?
    weak var viewDelegate: SearchViewDelegate?
}
