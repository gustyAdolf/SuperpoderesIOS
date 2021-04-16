//
//  CatalogueCellViewModel.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import Foundation

protocol CatalogueCellViewDelegate: class {
    func imageFetched(imageData: Data)
}

class CatalogueCellViewModel {
    weak var viewDelegate: CatalogueCellViewDelegate?
    var imageName: String?
    private var imageURL: String?
    private var catalogueDataManager: CatalogueDataManager?
    var imageData: Data?
    
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    init(imageURL: String, catalogueDataManager: CatalogueDataManager?) {
        self.imageURL = imageURL
        self.catalogueDataManager = catalogueDataManager
        fetchImageData()
    }
    
    func fetchImageData() {
        guard let catalogueDataManager = catalogueDataManager,
              let imageUrl = self.imageURL else {return}
        catalogueDataManager.fetchImageData(imageUrl: imageUrl) { [weak self] result in
            switch result {
                case .success(let data):
                    guard let data = data else {return}
                    self?.imageData = data
                    self?.viewDelegate?.imageFetched(imageData: data)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
